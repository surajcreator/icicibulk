<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    Sub Application_Start(sender As Object, e As EventArgs)
        'RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        RegisterRoutes(RouteTable.Routes)
    End Sub

    Private Shared Sub RegisterRoutes(routes As RouteCollection)
        routes.Ignore("{resource}.axd/{*pathInfo}")
        routes.MapPageRoute("index", "index", "~/index.aspx")
        routes.MapPageRoute("productCategory", "products/{category}", "~/productCategory.aspx")
    End Sub
</script>