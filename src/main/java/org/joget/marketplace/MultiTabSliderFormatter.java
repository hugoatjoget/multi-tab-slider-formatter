package org.joget.marketplace;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.joget.apps.app.service.AppPluginUtil;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.datalist.model.DataList;
import org.joget.apps.datalist.model.DataListColumn;
import org.joget.apps.datalist.model.DataListColumnFormatDefault;
import org.joget.apps.datalist.service.DataListService;
import org.joget.commons.util.LogUtil;
import org.joget.plugin.base.PluginManager;
import org.joget.workflow.util.WorkflowUtil;

public class MultiTabSliderFormatter extends DataListColumnFormatDefault {

    private final static String MESSAGE_PATH = "messages/MultiTabSliderFormatter";

    @Override
    public String getName() {
        return AppPluginUtil.getMessage("org.joget.marketplace.MultiTabSliderFormatter.pluginLabel", getClassName(), MESSAGE_PATH);
    }

    @Override
    public String getVersion() {
        return "1.0.0";
    }

    @Override
    public String getClassName() {
        return getClass().getName();
    }

    @Override
    public String getLabel() {
        //support i18n
        return AppPluginUtil.getMessage("org.joget.marketplace.MultiTabSliderFormatter.pluginLabel", getClassName(), MESSAGE_PATH);
    }

    @Override
    public String getDescription() {
        //support i18n
        return AppPluginUtil.getMessage("org.joget.marketplace.MultiTabSliderFormatter.pluginDesc", getClassName(), MESSAGE_PATH);
    }

    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClassName(), "/properties/MultiTabSliderFormatter.json", null, true, MESSAGE_PATH);
    }

    public String getHref() {
        return getPropertyString("href");
    }

    public String getHrefParam() {
        return getPropertyString("hrefParam");
    }

    public String getHrefColumn() {
        return getPropertyString("hrefColumn");
    }

    public String getTabNameColumn() {
        return getPropertyString("tabNameColumn");
    }

    public String getTabName(DataList dataList, Object row, Object value, String actionType, String idValue) {
        String tabNameColumn = getTabNameColumn();
        
        if (tabNameColumn != null && !tabNameColumn.isEmpty()) {
            // Use the specified column for tab name
            try {
                Object columnValue = DataListService.evaluateColumnValueFromRow(row, tabNameColumn);
                if (columnValue != null && !columnValue.toString().trim().isEmpty()) {
                    return columnValue.toString().trim();
                }
            } catch (Exception e) {
                LogUtil.warn(getClassName(), "Error getting tab name from column '" + tabNameColumn + "': " + e.getMessage());
            }
        }
        
        // Fallback to default tab name format (action type + ID)
        if (idValue != null && !idValue.isEmpty()) {
            String actionLabel = "edit".equalsIgnoreCase(actionType) ? "Edit" : "View";
            return actionLabel + " ID: " + idValue;
        } else {
            String actionLabel = "edit".equalsIgnoreCase(actionType) ? "Edit" : "View";
            return actionLabel + " Page";
        }
    }

    public String getLinkLabel(DataList dataList, Object row, Object value) {
        String label = getPropertyString("label");

        if (label != null && !label.isEmpty()) {
            Pattern pattern = Pattern.compile("\\{([^\\}]+)\\}");
            Matcher matcher = pattern.matcher(label);

            if (!matcher.find()) {
                return label;
            }

            matcher.reset();
            StringBuffer processedLabel = new StringBuffer();

            while (matcher.find()) {
                String columnName = matcher.group(1);
                Object columnValue = DataListService.evaluateColumnValueFromRow(row, columnName);
                String replacement;

                if (columnValue != null && !columnValue.toString().trim().isEmpty()) {
                    replacement = columnValue.toString();
                } else if (value != null && !value.toString().trim().isEmpty()) {
                    // Use current column value as fallback
                    replacement = value.toString();
                } else {
                    // Final fallback
                    replacement = "Hyperlink";
                }

                matcher.appendReplacement(processedLabel, Matcher.quoteReplacement(replacement));
            }

            matcher.appendTail(processedLabel);

            String finalLabel = processedLabel.toString().trim();
            return finalLabel.isEmpty() ? "Hyperlink" : finalLabel;
        } else if (value != null && !value.toString().trim().isEmpty()) {
            return value.toString();
        } else {
            return "Hyperlink";
        }
    }

    @Override
    public String format(DataList dataList, DataListColumn dlc, Object row, Object value) {
        String content = "";
        HttpServletRequest request = WorkflowUtil.getHttpServletRequest();

        try {
            LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Starting format process");
            
            if (request != null && request.getAttribute(getClassName()) == null) {
                LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Initializing template resources");

                PluginManager pluginManager = (PluginManager) AppUtil.getApplicationContext().getBean("pluginManager");
                if (pluginManager == null) {
                    LogUtil.error(getClassName(), new RuntimeException("PluginManager is null"), "Multi-Tab Slider Formatter: PluginManager is null");
                    return "<div style='color: red; font-weight: bold;'>Multi-Tab Slider: PluginManager not available</div>";
                }
                
                Map model = new HashMap();
                model.put("element", this);
                if (getPropertyString("width") != null) {
                    model.put("width", getPropertyString("width"));
                } else {
                    model.put("width", "50%");
                }
                
                // Pass edit mode setting to template
                boolean editMode = "true".equals(getPropertyString("editMode"));
                model.put("editMode", editMode);
                LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Edit mode enabled: " + editMode);
                
                // Pass styling properties to template
                Map<String, String> styling = new HashMap<>();
                styling.put("dockBackground", getPropertyString("dockBackground") != null ? getPropertyString("dockBackground") : "rgba(17, 23, 53, 0.95)");
                styling.put("dockBorder", getPropertyString("dockBorder") != null ? getPropertyString("dockBorder") : "2px solid rgba(255, 255, 255, 0.1)");
                styling.put("tabBackground", getPropertyString("tabBackground") != null ? getPropertyString("tabBackground") : "rgba(255, 255, 255, 0.1)");
                styling.put("tabActiveBackground", getPropertyString("tabActiveBackground") != null ? getPropertyString("tabActiveBackground") : "rgba(0, 123, 255, 0.8)");
                styling.put("tabTextColor", getPropertyString("tabTextColor") != null ? getPropertyString("tabTextColor") : "rgba(108, 117, 125, 0.8)");
                styling.put("buttonBackground", getPropertyString("buttonBackground") != null ? getPropertyString("buttonBackground") : "rgba(108, 117, 125, 0.8)");
                styling.put("buttonHoverBackground", getPropertyString("buttonHoverBackground") != null ? getPropertyString("buttonHoverBackground") : "rgba(52, 58, 64, 0.9)");
                styling.put("fontSize", getPropertyString("fontSize") != null ? getPropertyString("fontSize") : "14px");
                styling.put("fontWeight", getPropertyString("fontWeight") != null ? getPropertyString("fontWeight") : "500");
                styling.put("borderRadius", getPropertyString("borderRadius") != null ? getPropertyString("borderRadius") : "medium");
                styling.put("dockHeight", getPropertyString("dockHeight") != null ? getPropertyString("dockHeight") : "60px");
                styling.put("dockPadding", getPropertyString("dockPadding") != null ? getPropertyString("dockPadding") : "8px 12px");
                styling.put("tabPadding", getPropertyString("tabPadding") != null ? getPropertyString("tabPadding") : "8px 16px");
                styling.put("tabMinWidth", getPropertyString("tabMinWidth") != null ? getPropertyString("tabMinWidth") : "120px");
                styling.put("tabMaxWidth", getPropertyString("tabMaxWidth") != null ? getPropertyString("tabMaxWidth") : "200px");
                styling.put("controlButtonSize", getPropertyString("controlButtonSize") != null ? getPropertyString("controlButtonSize") : "36px");
                model.put("styling", styling);
                LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Styling configuration loaded");

                try {
                    content += pluginManager.getPluginFreeMarkerTemplate(model, getClass().getName(), "/template/multi-tab-slider.ftl", null);
                    LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Template rendered successfully");
                } catch (Exception templateException) {
                    LogUtil.error(getClassName(), templateException, "Multi-Tab Slider Formatter: Error loading template: " + templateException.getMessage());
                    // Fallback: return a simple error message instead of failing completely
                    return "<div style='color: red; font-weight: bold;'>Multi-Tab Slider: Template Error - " + templateException.getMessage() + "</div>";
                }

                request.setAttribute(getClassName(), true);
            }

            String url = getHref();
            String hrefParam = getHrefParam();
            String hrefColumn = getHrefColumn();
            
            LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Processing URL generation - Base URL: " + url);

            if (url == null || url.isEmpty()) {
                LogUtil.info(getClassName(), "No URL configured in href property");
            } else {
                LogUtil.info(getClassName(), "URL params - hrefParam: " + hrefParam + ", hrefColumn: " + hrefColumn);
                
                if (hrefParam != null && hrefColumn != null && !hrefColumn.isEmpty()) {
                    //DataListCollection rows = dataList.getRows();
                    //String primaryKeyColumnName = dataList.getBinder().getPrimaryKeyColumnName();

                    String[] params = hrefParam.split(";");
                    String[] columns = hrefColumn.split(";");

                    for (int i = 0; i < columns.length; i++) {
                        if (columns[i] != null && !columns[i].isEmpty()) {
                            boolean isValid = false;
                            if (params.length > i && params[i] != null && !params[i].isEmpty()) {
                                if (url.contains("?")) {
                                    url += "&";
                                } else {
                                    url += "?";
                                }
                                url += params[i];
                                url += "=";
                                isValid = true;
                            } else if (!url.contains("?")) {
                                if (!url.endsWith("/")) {
                                    url += "/";
                                }
                                isValid = true;
                            }

                            if (isValid) {
                                try {
                                    Object columnValue = DataListService.evaluateColumnValueFromRow(row, columns[i]);
                                    if (columnValue != null) {
                                        String val = columnValue.toString();
                                        url += val + ";";
                                        //url += getValue(row, columns[i]) + ";";
                                        url = url.substring(0, url.length() - 1);
                                        LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Parameter added - " + params[i] + "=" + val);
                                    } else {
                                        LogUtil.warn(getClassName(), "Multi-Tab Slider Formatter: Column value is null for column: " + columns[i]);
                                    }
                                } catch (Exception e) {
                                    LogUtil.error(getClassName(), e, "Multi-Tab Slider Formatter: Error evaluating column value for column: " + columns[i] + " - " + e.getMessage());
                                }
                            }
                        }
                    }
                }
            }
        
            // Append edit mode parameter if enabled
            String editMode = getPropertyString("editMode");
            if ("true".equals(editMode) && url.indexOf("_mode=edit") == -1) {
                String separator = url.contains("?") ? "&" : "?";
                url += separator + "_mode=edit";
                LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Edit mode parameter added to URL");
            }
        
            LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Final URL generated: " + url);

            // Extract ID value for tab name generation
            String idValue = null;
            String actionType = "true".equals(editMode) ? "edit" : "view";
            
            if (hrefParam != null && hrefColumn != null && !hrefColumn.isEmpty()) {
                String[] params = hrefParam.split(";");
                String[] columns = hrefColumn.split(";");
                
                for (int i = 0; i < columns.length && i < params.length; i++) {
                    if ("id".equals(params[i]) && columns[i] != null && !columns[i].isEmpty()) {
                        try {
                            Object idValueObj = DataListService.evaluateColumnValueFromRow(row, columns[i]);
                            if (idValueObj != null) {
                                idValue = idValueObj.toString();
                                break;
                            }
                        } catch (Exception e) {
                            LogUtil.warn(getClassName(), "Error getting ID value for tab name: " + e.getMessage());
                        }
                    }
                }
            }
            
            // Generate tab name using the new method
            String tabName = getTabName(dataList, row, value, actionType, idValue);
            if (tabName == null) {
                tabName = "Tab"; // Fallback tab name
            }
            LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Generated tab name: " + tabName);

            Object displayStyleObj = getProperty("link-css-display-type");
            String displayStyle = displayStyleObj != null ? displayStyleObj.toString() : "btn btn-primary";
            displayStyle += " noAjax no-close";

            // Create a safer button that checks if the function exists and passes tab name
            String buttonScript = "console.log('Button clicked for URL: " + url + "'); " +
                                  "if(typeof window.openMultiTabSlider === 'function') { " +
                                  "console.log('Function available, calling openMultiTabSlider'); " +
                                  "window.openMultiTabSlider('" + url + "', '" + actionType + "', '" + tabName.replaceAll("'", "\\\\'") + "'); " +
                                  "} else if(window.multiTabSliderReady && typeof window.openMultiTabSlider === 'function') { " +
                                  "console.log('Script ready, calling openMultiTabSlider'); " +
                                  "window.openMultiTabSlider('" + url + "', '" + actionType + "', '" + tabName.replaceAll("'", "\\\\'") + "'); " +
                                  "} else { " +
                                  "console.error('openMultiTabSlider not found - template may not be loaded'); " +
                                  "setTimeout(function(){ " +
                                  "if(typeof window.openMultiTabSlider === 'function'){ " +
                                  "console.log('Function available after delay, calling openMultiTabSlider'); " +
                                  "window.openMultiTabSlider('" + url + "', '" + actionType + "', '" + tabName.replaceAll("'", "\\\\'") + "'); " +
                                  "}else{ " +
                                  "alert('Slider not ready. Please refresh the page.'); " +
                                  "} " +
                                  "}, 100); " +
                                  "}";
        
            // Include template content only on first call, then just return the button
            String result;
            if (!content.isEmpty()) {
                result = content + "<a href=\"javascript:void(0);\" class=\"" + displayStyle + "\" onClick=\"event.preventDefault(); event.stopPropagation(); " + buttonScript + " return false;\">" + getLinkLabel(dataList, row, value) + "</a>";
            } else {
                result = "<a href=\"javascript:void(0);\" class=\"" + displayStyle + "\" onClick=\"event.preventDefault(); event.stopPropagation(); " + buttonScript + " return false;\">" + getLinkLabel(dataList, row, value) + "</a>";
            }
        
            LogUtil.info(getClassName(), "Multi-Tab Slider Formatter: Format process completed successfully");
            return result;
        
        } catch (Exception e) {
            LogUtil.error(getClassName(), e, "Multi-Tab Slider Formatter: Error occurred during format process: " + e.toString());
            // Return a simple fallback link in case of error
            return "<a href=\"#\" class=\"btn btn-sm btn-primary\">Edit</a>";
        }
    }
}
