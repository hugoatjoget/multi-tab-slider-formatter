<style>
/* Multi-Tab Slider Enhanced Styles with Dynamic Theming */

<#-- Process styling configuration from plugin settings -->
<#if styling??>
    <#-- Set defaults for styling variables with improved fallbacks -->
    <#assign dockBg = styling.dockBackground!'rgba(17, 23, 53, 0.95)'>
    <#assign dockBorderColor = styling.dockBorder!'#ffffff26'>
    <#assign tabBg = styling.tabBackground!'#ffffff1f'>
    <#assign tabActiveBg = styling.tabActiveBackground!'#007bff'>
    <#assign tabTextColor = styling.tabTextColor!'#ffffffe6'>
    <#assign buttonBg = styling.buttonBackground!'#6c757d26'>
    <#assign buttonHoverBg = styling.buttonHoverBackground!'#dc3545cc'>
    <#assign dockHeight = styling.dockHeight!'60px'>
    <#assign dockPadding = styling.dockPadding!'8px 12px'>
    <#assign tabPadding = styling.tabPadding!'8px 16px'>
    <#assign tabMinWidth = styling.tabMinWidth!'120px'>
    <#assign tabMaxWidth = styling.tabMaxWidth!'200px'>
    <#assign controlButtonSize = styling.controlButtonSize!'36px'>
    
    <#-- Enhanced font size processing -->
    <#assign fontSize = styling.fontSize!'medium'>
    <#if fontSize == 'small'>
        <#assign fontSize = '12px'>
        <#assign controlSize = '32px'>
    <#elseif fontSize == 'large'>
        <#assign fontSize = '16px'>
        <#assign controlSize = '44px'>
    <#elseif fontSize == 'xlarge'>
        <#assign fontSize = '18px'>
        <#assign controlSize = '48px'>
    <#else>
        <#assign fontSize = '14px'>
        <#assign controlSize = '40px'>
    </#if>
    
    <#-- Enhanced font weight processing -->
    <#assign fontWeight = styling.fontWeight!'normal'>
    <#if fontWeight == 'light'>
        <#assign fontWeight = '300'>
    <#elseif fontWeight == 'medium'>
        <#assign fontWeight = '500'>
    <#elseif fontWeight == 'bold'>
        <#assign fontWeight = '700'>
    <#elseif fontWeight == 'bolder'>
        <#assign fontWeight = '800'>
    <#else>
        <#assign fontWeight = '400'>
    </#if>
    
    <#-- Enhanced border radius processing -->
    <#assign borderRadius = styling.borderRadius!'medium'>
    <#if borderRadius == 'none'>
        <#assign borderRadius = '0px'>
    <#elseif borderRadius == 'small'>
        <#assign borderRadius = '6px'>
    <#elseif borderRadius == 'large'>
        <#assign borderRadius = '18px'>
    <#else>
        <#assign borderRadius = '12px'>
    </#if>
    
    <#-- Process dock border to include width if not specified -->
    <#-- Since dockBorderColor now comes from color picker, always prepend with border style -->
    <#assign dockBorder = '2px solid ' + dockBorderColor>
    
    :root {
        --dock-bg: ${dockBackground!'linear-gradient(135deg, rgba(17, 23, 53, 0.95), rgba(33, 45, 85, 0.95))'};
        --dock-border: ${dockBorder!'2px solid #ffffff26'};
        --tab-bg: ${tabBackground!'#ffffff1f'};
        --tab-active-bg: ${tabActiveBackground!'#007bff'};
        --tab-text-color: ${tabTextColor!'#ffffffe6'};
        --button-bg: ${buttonBackground!'#6c757d26'};
        --button-hover-bg: ${buttonHoverBackground!'#dc3545cc'};
        --custom-font-size: ${fontSize!'14px'};
        --custom-font-weight: ${fontWeight!'500'};
        --custom-border-radius: ${borderRadius!'12px'};
        --control-size: ${controlSize!'40px'};
        --dock-height: ${dockHeight!'60px'};
        --dock-padding: ${dockPadding!'8px 12px'};
        --tab-padding: ${tabPadding!'8px 16px'};
        --tab-min-width: ${tabMinWidth!'120px'};
        --tab-max-width: ${tabMaxWidth!'200px'};
        --control-button-size: ${controlButtonSize!'36px'};
        --tab-list-gap: ${tabListGap!'6px'};
        --tab-list-padding: ${tabListPadding!'0 8px'};
        --controls-gap: ${controlsGap!'8px'};
        --tab-close-opacity: ${tabCloseButtonOpacity!'0.7'};
    }
<#else>
    :root {
        --dock-bg: linear-gradient(135deg, rgba(17, 23, 53, 0.95), rgba(33, 45, 85, 0.95));
        --dock-border: 2px solid #ffffff26;
        --tab-bg: #ffffff1f;
        --tab-active-bg: #007bff;
        --tab-text-color: #ffffffe6;
        --button-bg: #6c757d26;
        --button-hover-bg: #dc3545cc;
        --custom-font-size: 14px;
        --custom-font-weight: 500;
        --custom-border-radius: 12px;
        --control-size: 40px;
        --dock-height: 60px;
        --dock-padding: 8px 12px;
        --tab-padding: 8px 16px;
        --tab-min-width: 120px;
        --tab-max-width: 200px;
        --control-button-size: 36px;
        --tab-list-gap: 6px;
        --tab-list-padding: 0 8px;
        --controls-gap: 8px;
        --tab-close-opacity: 0.7;
    }
</#if>

/* Main slider container */
#multiTabSlider {
    position: fixed;
    top: 0;
    right: -100%;
    width: ${width!'50%'};
    height: 100%;
    background-color: #fff;
    box-shadow: -2px 0 5px rgba(0, 0, 0, 0.5);
    transition: right 0.3s ease-in-out;
    overflow-y: auto;
    z-index: 9999;
    min-width: 300px;
    max-width: 90%;
}

/* Resize handle - Joget style */
.resize-handle {
    position: absolute;
    left: 0;
    top: 0;
    width: 6px;
    height: 100%;
    background: linear-gradient(to right, 
        rgba(0, 0, 0, 0.1) 0%, 
        rgba(0, 0, 0, 0.2) 50%, 
        rgba(0, 0, 0, 0.1) 100%);
    cursor: col-resize;
    z-index: 10001;
    transition: all 0.2s ease;
    border-left: 1px solid rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
}

.resize-handle:hover {
    background: linear-gradient(to right, 
        rgba(0, 123, 255, 0.3) 0%, 
        rgba(0, 123, 255, 0.5) 50%, 
        rgba(0, 123, 255, 0.3) 100%);
    width: 8px;
    border-left: 2px solid rgba(0, 123, 255, 0.6);
    box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
}

.resize-handle::before {
    content: '⋮⋮';
    color: rgba(255, 255, 255, 0.8);
    font-size: 14px;
    line-height: 8px;
    letter-spacing: -2px;
    writing-mode: vertical-lr;
    text-orientation: upright;
    opacity: 0.7;
    transition: all 0.2s ease;
    text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
}

.resize-handle:hover::before {
    opacity: 1;
    color: rgba(255, 255, 255, 1);
    text-shadow: 1px 1px 2px rgba(0, 123, 255, 0.5);
}

/* Show resize cursor for the entire left edge area */
#multiTabSlider::before {
    content: '';
    position: absolute;
    left: -3px;
    top: 0;
    width: 10px;
    height: 100%;
    cursor: col-resize;
    z-index: 10000;
}

/* Resizing state styles */
.resize-handle.resizing {
    background: linear-gradient(to right, 
        rgba(0, 123, 255, 0.5) 0%, 
        rgba(0, 123, 255, 0.7) 50%, 
        rgba(0, 123, 255, 0.5) 100%) !important;
    width: 10px !important;
    border-left: 3px solid rgba(0, 123, 255, 0.8) !important;
    box-shadow: 0 0 15px rgba(0, 123, 255, 0.5) !important;
}

.resize-handle.resizing::before {
    opacity: 1 !important;
    color: rgba(255, 255, 255, 1) !important;
    text-shadow: 2px 2px 3px rgba(0, 123, 255, 0.8) !important;
}

.resize-handle.resizing {
    background: rgba(0, 123, 255, 0.8);
    width: 6px;
}

#multiTabSlider.open {
    right: 0;
}

#multiTabSlider.minimized {
    right: -100%;
}

/* Minimize indicator - shows when slider is minimized */
.minimize-indicator {
    position: fixed;
    top: 50%;
    right: 0;
    transform: translateY(-50%);
    background: var(--dock-bg);
    color: var(--tab-text-color);
    padding: 8px 12px;
    border-top-left-radius: var(--custom-border-radius);
    border-bottom-left-radius: var(--custom-border-radius);
    cursor: pointer;
    z-index: 10000;
    transition: all 0.3s ease;
    display: none;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    box-shadow: -2px 0 10px rgba(0, 0, 0, 0.3);
    writing-mode: vertical-rl;
    text-orientation: mixed;
    font-size: var(--custom-font-size);
    font-weight: var(--custom-font-weight);
    min-height: 100px;
    align-items: center;
    justify-content: center;
}

.minimize-indicator:hover {
    background: var(--button-hover-bg);
    transform: translateY(-50%) translateX(-5px);
}

#multiTabSlider.minimized + .minimize-indicator {
    display: flex;
}

.minimize-indicator .indicator-text {
    margin-bottom: 8px;
    font-size: 12px;
    opacity: 0.8;
}

.minimize-indicator .tab-count {
    background: var(--tab-active-bg);
    color: rgba(255, 255, 255, 1);
    border-radius: 50%;
    width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 11px;
    font-weight: bold;
    margin-top: 4px;
}

/* Enhanced Tab dock styles using CSS custom properties */
.multi-tab-dock {
    display: flex;
    align-items: center;
    background: var(--dock-bg);
    border-bottom: var(--dock-border);
    padding: var(--dock-padding);
    height: var(--dock-height);
    position: sticky;
    top: 0;
    z-index: 10;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
}

.multi-tab-list {
    display: flex;
    flex: 1;
    overflow-x: auto;
    gap: var(--tab-list-gap);
    padding: var(--tab-list-padding);
    scrollbar-width: thin;
    scrollbar-color: rgba(255, 255, 255, 0.3) transparent;
}

.multi-tab-list::-webkit-scrollbar {
    height: 4px;
}

.multi-tab-list::-webkit-scrollbar-track {
    background: transparent;
}

.multi-tab-list::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.3);
    border-radius: 2px;
}

.multi-tab-list::-webkit-scrollbar-thumb:hover {
    background: rgba(255, 255, 255, 0.5);
}

.multi-tab-item {
    background: var(--tab-bg);
    border: none;
    color: var(--tab-text-color);
    padding: var(--tab-padding);
    border-radius: var(--custom-border-radius);
    cursor: pointer;
    white-space: nowrap;
    font-size: var(--custom-font-size);
    font-weight: var(--custom-font-weight);
    min-width: var(--tab-min-width);
    max-width: var(--tab-max-width);
    overflow: hidden;
    text-overflow: ellipsis;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    user-select: none;
}

.multi-tab-item:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.multi-tab-item.active {
    background: var(--tab-active-bg);
    color: rgba(255, 255, 255, 1);
    font-weight: 600;
    box-shadow: 0 2px 8px rgba(0, 123, 255, 0.3);
}

.multi-tab-item.active::after {
    content: '';
    position: absolute;
    bottom: -8px;
    left: 50%;
    transform: translateX(-50%);
    width: 60%;
    height: 3px;
    background: var(--tab-active-bg);
    border-radius: 2px;
}

.multi-tab-close {
    margin-left: 8px;
    opacity: 0;
    transition: opacity 0.2s ease;
    cursor: pointer;
    padding: 2px;
    border-radius: 3px;
}

.multi-tab-item:hover .multi-tab-close,
.multi-tab-item.active .multi-tab-close {
    opacity: var(--tab-close-opacity);
}

.multi-tab-close:hover {
    background: rgba(255, 255, 255, 0.2);
}

.multi-tab-controls {
    display: flex;
    gap: var(--controls-gap);
    margin-left: auto;
    align-items: center;
}

.multi-tab-control-btn {
    background: var(--button-bg);
    border: none;
    color: var(--tab-text-color);
    width: var(--control-button-size);
    height: var(--control-button-size);
    border-radius: var(--custom-border-radius);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    font-weight: bold;
    transition: all 0.2s ease;
    backdrop-filter: blur(5px);
    -webkit-backdrop-filter: blur(5px);
}

.multi-tab-control-btn:hover {
    background: var(--button-hover-bg);
    transform: scale(1.1);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.multi-tab-control-btn:active {
    transform: scale(0.95);
}

/* Enhanced styling for active tabs */
.multi-tab-item.active {
    background: var(--tab-active-bg) !important;
    color: rgba(255, 255, 255, 1) !important;
    font-weight: 600 !important;
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.4) !important;
    border: 2px solid rgba(255, 255, 255, 0.3) !important;
    transform: translateY(-2px) !important;
}

.multi-tab-item.active::before {
    content: '';
    position: absolute;
    top: -2px;
    left: -2px;
    right: -2px;
    bottom: -2px;
    background: linear-gradient(45deg, var(--tab-active-bg), rgba(0, 123, 255, 0.6));
    border-radius: var(--custom-border-radius);
    z-index: -1;
    opacity: 0.8;
}

.multi-tab-item.active::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 80%;
    height: 4px;
    background: var(--tab-active-bg);
    border-radius: 2px;
    box-shadow: 0 2px 6px rgba(0, 123, 255, 0.6);
}

/* Enhanced control buttons styling */
.multi-tab-control-btn {
    background: var(--button-bg) !important;
    border: 2px solid rgba(255, 255, 255, 0.2) !important;
    color: rgba(255, 255, 255, 1) !important;
    width: var(--control-size) !important;
    height: var(--control-size) !important;
    border-radius: var(--custom-border-radius) !important;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: calc(var(--custom-font-size) * 1.4) !important;
    font-weight: bold;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    position: relative;
    overflow: hidden;
}

.multi-tab-control-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
}

.multi-tab-control-btn:hover {
    background: var(--button-hover-bg) !important;
    transform: scale(1.15) !important;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4) !important;
    border-color: rgba(255, 255, 255, 0.4) !important;
}

.multi-tab-control-btn:hover::before {
    left: 100%;
}

.multi-tab-control-btn:active {
    transform: scale(0.95) !important;
}

.multi-tab-control-btn span {
    position: relative;
    z-index: 1;
}

/* Enhanced minimize indicator styling */
.minimize-indicator {
    position: fixed;
    top: 50%;
    right: 0;
    transform: translateY(-50%);
    background: var(--dock-bg) !important;
    color: var(--tab-text-color) !important;
    padding: 12px 8px !important;
    border-top-left-radius: var(--custom-border-radius) !important;
    border-bottom-left-radius: var(--custom-border-radius) !important;
    cursor: pointer;
    z-index: 10000;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1) !important;
    display: none;
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    box-shadow: -4px 0 20px rgba(0, 0, 0, 0.4) !important;
    writing-mode: vertical-rl;
    text-orientation: mixed;
    font-size: var(--custom-font-size) !important;
    font-weight: var(--custom-font-weight) !important;
    min-height: 120px;
    align-items: center;
    justify-content: center;
    border: 2px solid rgba(255, 255, 255, 0.1);
    border-right: none;
}

.minimize-indicator:hover {
    background: var(--button-hover-bg) !important;
    transform: translateY(-50%) translateX(-8px) !important;
    box-shadow: -6px 0 25px rgba(0, 0, 0, 0.5) !important;
    border-color: rgba(255, 255, 255, 0.3);
}

.minimize-indicator .indicator-text {
    margin-bottom: 12px;
    font-size: 11px;
    opacity: 0.9;
    font-weight: 500;
    letter-spacing: 1px;
    text-transform: uppercase;
}

.minimize-indicator .tab-count {
    background: var(--tab-active-bg) !important;
    color: rgb(255 255 255) !important;
    border-radius: 50% !important;
    width: 24px !important;
    height: 24px !important;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px !important;
    font-weight: bold !important;
    margin-top: 8px;
    box-shadow: 0 2px 8px rgba(0, 123, 255, 0.4);
    border: 2px solid rgba(255, 255, 255, 0.2);
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% {
        box-shadow: 0 0 0 0 rgba(0, 123, 255, 0.7);
    }
    70% {
        box-shadow: 0 0 0 10px rgba(0, 123, 255, 0);
    }
    100% {
        box-shadow: 0 0 0 0 rgba(0, 123, 255, 0);
    }
}

/* Content area */
.multi-tab-content {
    padding: 0;
    height: calc(100% - 60px);
    overflow: hidden;
    position: relative;
}

.multi-tab-content iframe {
    width: 100%;
    height: 100%;
    border: none;
    display: block;
}

/* Enhanced Loading animation */
.multi-tab-loading {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 200px;
    font-size: 16px;
    color: #666;
    flex-direction: column;
    gap: 16px;
}

.spinner {
    width: 50px;
    height: 50px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid var(--tab-active-bg);
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Responsive design */
@media (max-width: 768px) {
    :root {
        --control-size: 32px;
        --custom-font-size: 12px;
    }
    
    #multiTabSlider {
        width: 95% !important;
        min-width: 280px;
    }
    
    .multi-tab-dock {
        padding: 6px 8px;
        height: 50px;
    }
    
    .multi-tab-item {
        padding: 6px 12px;
        font-size: 13px;
        min-width: 100px;
        max-width: 150px;
    }
    
    .minimize-indicator {
        min-height: 100px;
        padding: 10px 6px !important;
    }
    
    .minimize-indicator .tab-count {
        width: 20px !important;
        height: 20px !important;
        font-size: 10px !important;
    }
}

/* Animation enhancements */
.multi-tab-item {
    animation: slideInFromTop 0.3s ease-out;
}

@keyframes slideInFromTop {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

#multiTabSlider.open {
    animation: slideInFromRight 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

@keyframes slideInFromRight {
    from {
        right: -100%;
    }
    to {
        right: 0;
    }
}
</style>

<!-- Multi-Tab Slider HTML -->
<div id="multiTabSlider">
    <div class="resize-handle" id="resizeHandle"></div>
    <div class="multi-tab-dock">
        <div class="multi-tab-list" id="multiTabList">
            <!-- Tabs will be added dynamically -->
        </div>
        <div class="multi-tab-controls">
            <button class="multi-tab-control-btn" id="minimizeBtn" title="Minimize" type="button">
                <span>_</span>
            </button>
            <button class="multi-tab-control-btn" id="closeBtn" title="Close" type="button">
                <span>×</span>
            </button>
        </div>
    </div>
    <div class="multi-tab-content" id="multiTabContent">
        <div class="multi-tab-loading" id="multiTabLoading">
            <div class="spinner"></div>
            Loading...
        </div>
    </div>
</div>

<!-- Minimize Indicator - appears when slider is minimized -->
<div class="minimize-indicator" id="minimizeIndicator" title="Restore Multi-Tab Slider">
    <div class="indicator-text">Tabs</div>
    <div class="tab-count" id="tabCount">0</div>
</div>

<script type="text/javascript">
    (function() {

        // Global variables
        var multiTabSliderTabs = [];
        var activeMultiTabId = null;
        var editModeEnabled = ${editMode?c!false};

        // Flag to prevent double initialization
        var isInitialized = false;

        function safeInitialize() {
            if (isInitialized) {
                return;
            }
            
            var slider = document.getElementById('multiTabSlider');
            if (!slider) {
                // Retry after a short delay
                setTimeout(safeInitialize, 50);
                return;
            }
            
            isInitialized = true;
            initializeMultiTabSlider();
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', function() {
                setTimeout(safeInitialize, 50);
            });
        } else {
            // Strategy 2: DOM is already ready (script loaded late)
            setTimeout(safeInitialize, 50);
        }

        setTimeout(function() {
            if (!isInitialized) {
                safeInitialize();
            }
        }, 500);

        function initializeMultiTabSlider() {
            var slider = document.getElementById('multiTabSlider');
            if (!slider) {
                return false;
            }
            
            var requiredElements = {
                'multiTabList': document.getElementById('multiTabList'),
                'multiTabContent': document.getElementById('multiTabContent'),
                'minimizeBtn': document.getElementById('minimizeBtn'),
                'closeBtn': document.getElementById('closeBtn'),
                'minimizeIndicator': document.getElementById('minimizeIndicator'),
                'resizeHandle': document.getElementById('resizeHandle')
            };
            
            var missingElements = [];
            for (var key in requiredElements) {
                if (!requiredElements[key]) {
                    missingElements.push(key);
                }
            }
            
            if (missingElements.length > 0) {
                return false;
            }

            
            initializeResizeHandle();
            
            initializeClickAwayMinimize();
            
            var minimizeBtn = requiredElements['minimizeBtn'];
            var closeBtn = requiredElements['closeBtn'];
            
            var newMinimizeBtn = minimizeBtn.cloneNode(true);
            minimizeBtn.parentNode.replaceChild(newMinimizeBtn, minimizeBtn);
            
            var newCloseBtn = closeBtn.cloneNode(true);
            closeBtn.parentNode.replaceChild(newCloseBtn, closeBtn);
            
            newMinimizeBtn.addEventListener('click', function(e) {
                e.stopPropagation(); // Prevent event from bubbling up
                e.preventDefault(); // Prevent default behavior
                minimizeMultiTabSlider();
            });
            
            newCloseBtn.addEventListener('click', function(e) {
                e.stopPropagation(); // Prevent event from bubbling up
                e.preventDefault(); // Prevent default behavior
                closeMultiTabSlider();
            });
            
            // Initialize minimize indicator click handler
            var minimizeIndicator = requiredElements['minimizeIndicator'];
            var newMinimizeIndicator = minimizeIndicator.cloneNode(true);
            minimizeIndicator.parentNode.replaceChild(newMinimizeIndicator, minimizeIndicator);
            
            newMinimizeIndicator.addEventListener('click', function(e) {
                e.stopPropagation();
                e.preventDefault();
                restoreMultiTabSlider();
            });
            
            return true;
        }

        function initializeResizeHandle() {
            var resizeHandle = document.getElementById('resizeHandle');
            var slider = document.getElementById('multiTabSlider');
            
            if (!resizeHandle || !slider) {
                return;
            }
            
            var isResizing = false;
            var startX = 0;
            var startWidth = 0;
            
            resizeHandle.addEventListener('mousedown', function(e) {
                isResizing = true;
                startX = e.clientX;
                startWidth = slider.offsetWidth;
                resizeHandle.classList.add('resizing');
                
                // Add tooltip to resize handle
                resizeHandle.title = 'Drag to resize right panel';
                
                // Prevent text selection during resize
                document.body.style.userSelect = 'none';
                document.body.style.cursor = 'col-resize';
                slider.style.transition = 'none'; // Disable transition during resize
                
                e.preventDefault();
                e.stopPropagation();
            });
            
            document.addEventListener('mousemove', function(e) {
                if (!isResizing) return;
                
                var deltaX = startX - e.clientX; // Invert delta for right-side resize
                var newWidth = startWidth + deltaX;
                
                // Apply constraints
                var minWidth = 300;
                var maxWidth = window.innerWidth * 0.9;
                
                newWidth = Math.max(minWidth, Math.min(maxWidth, newWidth));
                
                slider.style.width = newWidth + 'px';
                
                e.preventDefault();
            });
            
            document.addEventListener('mouseup', function() {
                if (isResizing) {
                    isResizing = false;
                    resizeHandle.classList.remove('resizing');
                    document.body.style.userSelect = '';
                    document.body.style.cursor = '';
                    slider.style.transition = ''; // Re-enable transitions
                    
                    // Store the new width for persistence
                    localStorage.setItem('multiTabSliderWidth', slider.style.width);
                }
            });
            
            var savedWidth = localStorage.getItem('multiTabSliderWidth');
            if (savedWidth) {
                slider.style.width = savedWidth;
            }
        }

        function initializeClickAwayMinimize() {
            var slider = document.getElementById('multiTabSlider');
            if (!slider) return;
            
            document.addEventListener('click', function(e) {
                // Only handle when slider is open and not minimized
                if (!slider.classList.contains('open') || slider.classList.contains('minimized')) {
                    return;
                }
                
                var isClickInsideSlider = slider.contains(e.target);
                
                var minimizeIndicator = document.getElementById('minimizeIndicator');
                var isClickOnIndicator = minimizeIndicator && minimizeIndicator.contains(e.target);
                
                var isClickOnTab = e.target.closest('.multi-tab-item') || 
                                e.target.closest('.multi-tab-close') ||
                                e.target.closest('.multi-tab-list') ||
                                e.target.closest('.multi-tab-dock') ||
                                e.target.closest('.multi-tab-controls') ||
                                e.target.closest('.multi-tab-control-btn') ||
                                e.target.closest('#minimizeBtn') ||
                                e.target.closest('#closeBtn');
                
                var isClickOnTrigger = e.target.closest('[onclick*="openMultiTabSlider"]') || 
                                    e.target.closest('a[href*="openMultiTabSlider"]') ||
                                    e.target.closest('.datalist-action-link') ||
                                    e.target.closest('.form-button') ||
                                    e.target.closest('[data-action*="multi-tab"]');
                
                var isClickOnResizeHandle = e.target.closest('.resize-handle');
                
                if (!isClickInsideSlider && !isClickOnIndicator && !isClickOnTrigger && !isClickOnTab && !isClickOnResizeHandle) {
                    minimizeMultiTabSlider();
                }
            }, true);
            
        }

        function makeMultiTabId(url) {
            try {
                var urlParts = url.split('?');
                var baseUrl = urlParts[0];
                var idParam = null;
                
                if (urlParts[1]) {
                    var params = urlParts[1].split('&');
                    for (var i = 0; i < params.length; i++) {
                        var pair = params[i].split('=');
                        if (pair[0] === 'id' && pair[1]) {
                            idParam = decodeURIComponent(pair[1]);
                            break;
                        }
                    }
                }
                
                var tabIdentifier = baseUrl;
                if (idParam) {
                    tabIdentifier += '_id_' + idParam;
                }
                
                return btoa(encodeURIComponent(tabIdentifier)).replace(/[+/=]/g, function(match) {
                    return { '+': '-', '/': '_', '=': '' }[match];
                });
            } catch (e) {
                return 'tab_' + Date.now();
            }
        }

        function validateUrl(url) {
            try {
                // Check if URL is valid
                var testUrl;
                if (url.startsWith('http')) {
                    testUrl = new URL(url);
                } else if (url.startsWith('/')) {
                    testUrl = new URL(window.location.origin + url);
                } else {
                    testUrl = new URL(url, window.location.href);
                }
                
                return testUrl.toString();
            } catch (e) {
                return null;
            }
        }

        function openMultiTabSlider(url, actionType, customTabName) {
            try {

                var validatedUrl = validateUrl(url);
                if (!validatedUrl) {
                    alert('Invalid URL: ' + url);
                    return;
                }
                
                var slider = document.getElementById('multiTabSlider');
                if (!slider) {
                    console.error('Slider element not found');
                    return;
                }
                
                var tabId = makeMultiTabId(url);
                
                var existingTab = multiTabSliderTabs.find(function(tab) {
                    return tab.id === tabId;
                });
                
                if (existingTab) {
                    setActiveMultiTab(tabId);
                } else {
                    addMultiTabSliderTab(validatedUrl, tabId, actionType || 'view', customTabName);
                }
                
                slider.classList.remove('minimized');
                slider.classList.add('open');
                
            } catch (error) {
                alert('Error opening slider: ' + error.message);
            }
        }

        function addMultiTabSliderTab(url, tabId, actionType, customTabName) {
            try {
                var tabTitle;
                var urlParts = url.split('?');
                var idParam = null;
                
                if (urlParts[1]) {
                    var params = urlParts[1].split('&');
                    for (var i = 0; i < params.length; i++) {
                        var pair = params[i].split('=');
                        if (pair[0] === 'id' && pair[1]) {
                            idParam = decodeURIComponent(pair[1]);
                            break;
                        }
                    }
                }
                
                if (customTabName && customTabName.trim() !== '') {
                    tabTitle = customTabName.trim();
                } else {
                    if (idParam) {
                        tabTitle = (actionType === 'edit' ? 'Edit' : 'View') + ' ID: ' + idParam;
                    } else {
                        tabTitle = (actionType === 'edit' ? 'Edit' : 'View') + ' Page ' + (multiTabSliderTabs.length + 1);
                    }
                }
                
                var newTab = {
                    id: tabId,
                    url: url,
                    title: tabTitle,
                    actionType: actionType || 'view',
                    originalUrl: url,
                    recordId: idParam
                };
                
                multiTabSliderTabs.push(newTab);
                
                renderMultiTabList();
                setActiveMultiTab(tabId);
                updateTabCountIndicator();
                
            } catch (error) {
                // Error adding tab
            }
        }

        function renderMultiTabList() {
            var tabList = document.getElementById('multiTabList');
            if (!tabList) {
                return;
            }
            
            tabList.innerHTML = '';
            
            multiTabSliderTabs.forEach(function(tab) {
                var tabElement = document.createElement('button');
                tabElement.className = 'multi-tab-item';
                tabElement.onclick = function(e) {
                    e.stopPropagation(); 
                    setActiveMultiTab(tab.id);
                };
                
                if (tab.id === activeMultiTabId) {
                    tabElement.classList.add('active');
                }
                
                // Create tab content with title and close button
                var tabTitle = document.createElement('span');
                tabTitle.textContent = tab.title;
                
                var closeButton = document.createElement('span');
                closeButton.className = 'multi-tab-close';
                closeButton.innerHTML = '×';
                closeButton.onclick = function(e) {
                    e.stopPropagation();
                    closeTab(tab.id);
                };
                
                tabElement.appendChild(tabTitle);
                tabElement.appendChild(closeButton);
                
                tabList.appendChild(tabElement);
            });
        }

        function closeTab(tabId) {
            try {
                // Find the tab index
                var tabIndex = multiTabSliderTabs.findIndex(function(tab) {
                    return tab.id === tabId;
                });
                
                // Remove the iframe for this tab
                var contentDiv = document.getElementById('multiTabContent');
                if (contentDiv) {
                    var iframe = contentDiv.querySelector('iframe[data-tab-id="' + tabId + '"]');
                    if (iframe) {
                        iframe.remove();
                    }
                }
                
                multiTabSliderTabs.splice(tabIndex, 1);
                
                if (tabId === activeMultiTabId) {
                    if (multiTabSliderTabs.length > 0) {
                        var newIndex = tabIndex >= multiTabSliderTabs.length ? tabIndex - 1 : tabIndex;
                        setActiveMultiTab(multiTabSliderTabs[newIndex].id);
                    } else {
                        closeMultiTabSlider();
                        return;
                    }
                }
                
                renderMultiTabList();
                updateTabCountIndicator();
                
            } catch (error) {
                // Error closing tab
            }
        }

        function setActiveMultiTab(tabId) {
            try {
                var tab = multiTabSliderTabs.find(function(t) {
                    return t.id === tabId;
                });
                
                if (!tab) {
                    return;
                }

                // If already on this tab, just return (no reload)
                if (activeMultiTabId === tabId) {
                    renderMultiTabList();
                    return;
                }

                // Capture current tab's form state before switching
                if (activeMultiTabId) {
                    var currentContentDiv = document.getElementById('multiTabContent');
                    var currentIframe = currentContentDiv ? currentContentDiv.querySelector('iframe') : null;
                    if (currentIframe) {
                        // Form state is preserved naturally in the iframe DOM
                    }
                }
                
                activeMultiTabId = tabId;
                renderMultiTabList();
                
                // Load the tab content (only when switching to a different tab)
                loadMultiTabContent(tab.originalUrl || tab.url, tabId);
                
            } catch (error) {
                // Error setting active tab
            }
        }

        function loadMultiTabContent(url, tabId) {
            var contentDiv = document.getElementById('multiTabContent');
            var loadingDiv = document.getElementById('multiTabLoading');

            if (!contentDiv) {
                return;
            }

            // Check if iframe for this tab already exists
            var existingIframe = contentDiv.querySelector('iframe[data-tab-id="' + tabId + '"]');
            
            if (existingIframe) {
                // Tab already loaded - just show it and hide others
                var allIframes = contentDiv.querySelectorAll('iframe');
                allIframes.forEach(function(iframe) {
                    iframe.style.display = 'none';
                });
                
                existingIframe.style.display = 'block';
                
                if (loadingDiv) {
                    loadingDiv.style.display = 'none';
                }
                
                return;
            }

            // New tab - create and load iframe
            if (loadingDiv) {
                loadingDiv.style.display = 'flex';
            }

            // Hide all other iframes
            var allIframes = contentDiv.querySelectorAll('iframe');
            allIframes.forEach(function(iframe) {
                iframe.style.display = 'none';
            });

            var iframe = document.createElement('iframe');
            iframe.setAttribute('data-tab-id', tabId);
            iframe.src = url;
            iframe.style.display = 'none';

            iframe.onload = function() {
                if (loadingDiv) {
                    loadingDiv.style.display = 'none';
                }
                iframe.style.display = 'block';
            };

            iframe.onerror = function() {
                if (loadingDiv) {
                    loadingDiv.innerHTML = '<div style="color: red;">Error loading content</div>';
                }
            };

            contentDiv.appendChild(iframe);
        }

        function closeMultiTabSlider() {
            var slider = document.getElementById('multiTabSlider');
            if (slider) {
                slider.classList.remove('open', 'minimized');
            }
            
            multiTabSliderTabs = [];
            activeMultiTabId = null;
            updateTabCountIndicator();
            
            var tabList = document.getElementById('multiTabList');
            if (tabList) {
                tabList.innerHTML = '';
            }
            
            var contentDiv = document.getElementById('multiTabContent');
            if (contentDiv) {
                var iframes = contentDiv.querySelectorAll('iframe');
                iframes.forEach(function(iframe) {
                    iframe.remove();
                });
                var loadingDiv = document.getElementById('multiTabLoading');
                if (loadingDiv) {
                    loadingDiv.style.display = 'flex';
                    loadingDiv.innerHTML = '<div class="spinner"></div>Loading...';
                }
            }
        }

        function minimizeMultiTabSlider() {
            var slider = document.getElementById('multiTabSlider');
            var indicator = document.getElementById('minimizeIndicator');
            
            if (slider) {
                if (slider.classList.contains('minimized')) {
                    restoreMultiTabSlider();
                } else {
                    slider.classList.add('minimized');
                    updateTabCountIndicator();
                }
            }
        }

        function restoreMultiTabSlider() {
            var slider = document.getElementById('multiTabSlider');
            if (slider) {
                slider.classList.remove('minimized');
                slider.classList.add('open');
            }
        }

        function updateTabCountIndicator() {
            var tabCount = document.getElementById('tabCount');
            if (tabCount) {
                tabCount.textContent = multiTabSliderTabs.length;
            }
        }

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && activeMultiTabId) {
                minimizeMultiTabSlider();
            }
            if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'w' && activeMultiTabId) {
                e.preventDefault();
                closeMultiTabSlider();
            }
        });

        window.openMultiTabSlider = openMultiTabSlider;
        window.closeMultiTabSlider = closeMultiTabSlider;
        window.minimizeMultiTabSlider = minimizeMultiTabSlider;
        window.restoreMultiTabSlider = restoreMultiTabSlider;
        window.setActiveMultiTab = setActiveMultiTab;
        window.closeTab = closeTab;
        window.validateUrl = validateUrl;

        // Set ready flag only after all functions are assigned
        setTimeout(function() {
            window.multiTabSliderReady = true;
        }, 100);
    })();

</script>
