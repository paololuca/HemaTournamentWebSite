<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="_oldMenu.aspx.cs" Inherits="WebApplication2._oldMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>Demo HemaTournament WebSite</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
        href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
        rel="stylesheet" />

    <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <script src="../assets/js/config.js"></script>
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>


    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
    <form id="form1" runat="server">
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->

                <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                    <div class="app-brand demo">
                        <a href="index.html" class="app-brand-link">
                            <span class="app-brand-logo demo"></span>
                            <span class="app-brand-text demo menu-text fw-bold ms-2">Hema</span>
                        </a>

                        <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                            <i class="bx bx-chevron-left bx-sm d-flex align-items-center justify-content-center"></i>
                        </a>
                    </div>

                    <div class="menu-inner-shadow"></div>

                    <ul class="menu-inner py-1">


                        <!-- Apps & Pages -->
                        <li class="menu-header small text-uppercase">
                            <span class="menu-header-text">Apps &amp; Pages</span>
                        </li>

                        <!-- Pages -->
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-dock-top"></i>
                                <div class="text-truncate" data-i18n="Account Settings">Account Settings</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="pages-account-settings-account.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Account">Account</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="pages-account-settings-notifications.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Notifications">Notifications</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="pages-account-settings-connections.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Connections">Connections</div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                                <div class="text-truncate" data-i18n="Authentications">Authentications</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="auth-login-basic.html" class="menu-link" target="_blank">
                                        <div class="text-truncate" data-i18n="Basic">Login</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="auth-register-basic.html" class="menu-link" target="_blank">
                                        <div class="text-truncate" data-i18n="Basic">Register</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="auth-forgot-password-basic.html" class="menu-link" target="_blank">
                                        <div class="text-truncate" data-i18n="Basic">Forgot Password</div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-cube-alt"></i>
                                <div class="text-truncate" data-i18n="Misc">Misc</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="pages-misc-error.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Error">Error</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="pages-misc-under-maintenance.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Under Maintenance">Under Maintenance</div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Components -->
                        <li class="menu-header small text-uppercase"><span class="menu-header-text">Components</span></li>
                        <!-- Cards -->
                        <li class="menu-item active">
                            <a href="cards-basic.html" class="menu-link">
                                <i class="menu-icon tf-icons bx bx-collection"></i>
                                <div class="text-truncate" data-i18n="Basic">Cards</div>
                            </a>
                        </li>
                        <!-- User interface -->
                        <li class="menu-item">
                            <a href="javascript:void(0)" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-box"></i>
                                <div class="text-truncate" data-i18n="User interface">User interface</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="ui-accordion.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Accordion">Accordion</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-alerts.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Alerts">Alerts</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-badges.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Badges">Badges</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-buttons.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Buttons">Buttons</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-carousel.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Carousel">Carousel</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-collapse.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Collapse">Collapse</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-dropdowns.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Dropdowns">Dropdowns</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-footer.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Footer">Footer</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-list-groups.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="List Groups">List groups</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-modals.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Modals">Modals</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-navbar.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Navbar">Navbar</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-offcanvas.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Offcanvas">Offcanvas</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-pagination-breadcrumbs.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Pagination & Breadcrumbs">Pagination &amp; Breadcrumbs</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-progress.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Progress">Progress</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-spinners.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Spinners">Spinners</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-tabs-pills.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Tabs & Pills">Tabs &amp; Pills</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-toasts.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Toasts">Toasts</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-tooltips-popovers.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Tooltips & Popovers">Tooltips &amp; Popovers</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="ui-typography.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Typography">Typography</div>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <!-- Extended components -->
                        <li class="menu-item">
                            <a href="javascript:void(0)" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-copy"></i>
                                <div class="text-truncate" data-i18n="Extended UI">Extended UI</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="extended-ui-perfect-scrollbar.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Perfect Scrollbar">Perfect Scrollbar</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="extended-ui-text-divider.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Text Divider">Text Divider</div>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="menu-item">
                            <a href="icons-boxicons.html" class="menu-link">
                                <i class="menu-icon tf-icons bx bx-crown"></i>
                                <div class="text-truncate" data-i18n="Boxicons">Boxicons</div>
                            </a>
                        </li>

                        <!-- Forms & Tables -->
                        <li class="menu-header small text-uppercase"><span class="menu-header-text">Forms &amp; Tables</span></li>
                        <!-- Forms -->
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-detail"></i>
                                <div class="text-truncate" data-i18n="Form Elements">Form Elements</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="forms-basic-inputs.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Basic Inputs">Basic Inputs</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="forms-input-groups.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Input groups">Input groups</div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link menu-toggle">
                                <i class="menu-icon tf-icons bx bx-detail"></i>
                                <div class="text-truncate" data-i18n="Form Layouts">Form Layouts</div>
                            </a>
                            <ul class="menu-sub">
                                <li class="menu-item">
                                    <a href="form-layouts-vertical.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Vertical Form">Vertical Form</div>
                                    </a>
                                </li>
                                <li class="menu-item">
                                    <a href="form-layouts-horizontal.html" class="menu-link">
                                        <div class="text-truncate" data-i18n="Horizontal Form">Horizontal Form</div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- Form Validation -->
                        <li class="menu-item">
                            <a
                                href="https://demos.themeselection.com/sneat-bootstrap-html-admin-template/html/vertical-menu-template/form-validation.html"
                                target="_blank"
                                class="menu-link">
                                <i class="menu-icon tf-icons bx bx-list-check"></i>
                                <div class="text-truncate" data-i18n="Form Validation">Form Validation</div>
                                <div class="badge rounded-pill bg-label-primary text-uppercase fs-tiny ms-auto">Pro</div>
                            </a>
                        </li>
                        <!-- Tables -->
                        <li class="menu-item">
                            <a href="tables-basic.html" class="menu-link">
                                <i class="menu-icon tf-icons bx bx-table"></i>
                                <div class="text-truncate" data-i18n="Tables">Tables</div>
                            </a>
                        </li>
                        <!-- Data Tables -->
                        <li class="menu-item">
                            <a
                                href="https://demos.themeselection.com/sneat-bootstrap-html-admin-template/html/vertical-menu-template/tables-datatables-basic.html"
                                target="_blank"
                                class="menu-link">
                                <i class="menu-icon tf-icons bx bx-grid"></i>
                                <div class="text-truncate" data-i18n="Datatables">Datatables</div>
                                <div class="badge rounded-pill bg-label-primary text-uppercase fs-tiny ms-auto">Pro</div>
                            </a>
                        </li>
                    </ul>
                </aside>
                <!-- / Menu -->

                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->

                    <nav
                        class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                        id="layout-navbar">
                        <div class="layout-menu-toggle navbar-nav align-items-xl-center me-4 me-xl-0 d-xl-none">
                            <a class="nav-item nav-link px-0 me-xl-10" href="javascript:void(0)">
                                <i class="bx bx-menu bx-md"></i>

                            </a>
                        </div>

                    </nav>

                    <!-- / Navbar -->

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="demo-inline-spacing">
                                <div class="container body-content">
                                    <asp:ContentPlaceHolder ID="MainContent" runat="server">
                                    </asp:ContentPlaceHolder>
                                    <hr />
                                    <!-- Footer -->
                                    <footer>
                                        <script>
                                            document.write(new Date().getFullYear());
                                        </script>
                                        , made with ❤️ by Pielle using 
                                        <a href="https://themeselection.com" target="_blank" class="footer-link">ThemeSelection</a>
                                    </footer>
                                    <!-- / Footer -->
                                </div>
                                <!-- / Content -->
                                <div class="content-backdrop fade"></div>
                            </div>
                            <!-- Content wrapper -->
                        </div>
                        <!-- / Layout page -->
                    </div>

                    <!-- Overlay -->
                    <div class="layout-overlay layout-menu-toggle"></div>

                    <!-- Core JS -->
                    <!-- build:js assets/vendor/js/core.js -->

                    <script src="../assets/vendor/libs/jquery/jquery.js"></script>
                    <script src="../assets/vendor/libs/popper/popper.js"></script>
                    <script src="../assets/vendor/js/bootstrap.js"></script>
                    <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
                    <script src="../assets/vendor/js/menu.js"></script>

                    <!-- endbuild -->

                    <!-- Vendors JS -->
                    <script src="../assets/vendor/libs/masonry/masonry.js"></script>

                    <!-- Main JS -->
                    <script src="../assets/js/main.js"></script>

                    <!-- Page JS -->

                    <!-- Place this tag before closing body tag for github widget button. -->
                    <script async defer src="https://buttons.github.io/buttons.js"></script>
                </div>
                <!-- / Layout wrapper -->
            </div>
        </div>
    </form>
</body>
</html>
