<#-- Shared Navigation Component with Dropdowns -->
<nav id="mainNav">
    <button class="menu-close-btn" id="menuCloseBtn" aria-label="Close menu">
        <i class="fas fa-times"></i>
    </button>
    <a href="/" <#if currentPage == "dashboard">class="active"</#if>>Dashboard</a>
    
    <div class="nav-dropdown" <#if currentPage?matches("flocks|egg-production|health-records|mortality")>class="active"</#if>>
        <a href="/flocks"><i class="fas fa-users"></i> Management</a>
        <div class="dropdown-menu">
            <a href="/flocks" <#if currentPage == "flocks">class="active"</#if>><i class="fas fa-layer-group"></i> Flock Management</a>
            <a href="/egg-production" <#if currentPage == "egg-production">class="active"</#if>><i class="fas fa-egg"></i> Egg Production</a>
            <a href="/health-records" <#if currentPage == "health-records">class="active"</#if>><i class="fas fa-heartbeat"></i> Health Records</a>
            <a href="/mortality" <#if currentPage == "mortality">class="active"</#if>><i class="fas fa-skull"></i> Mortality</a>
        </div>
    </div>
    
    <div class="nav-dropdown" <#if currentPage?matches("inventory|financials")>class="active"</#if>>
        <a href="/inventory"><i class="fas fa-boxes"></i> Operations</a>
        <div class="dropdown-menu">
            <a href="/inventory" <#if currentPage == "inventory">class="active"</#if>><i class="fas fa-box"></i> Inventory</a>
            <a href="/financials" <#if currentPage == "financials">class="active"</#if>><i class="fas fa-dollar-sign"></i> Financials</a>
        </div>
    </div>
    
    <a href="/reports" <#if currentPage == "reports">class="active"</#if>><i class="fas fa-chart-bar"></i> Reports</a>
</nav>

