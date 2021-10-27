Cache msbuild packages from a machine connected to the internet and then move the them where you want to install.
The following command are taken from the following link.
https://docs.microsoft.com/en-us/visualstudio/install/create-an-offline-installation-of-visual-studio?view=vs-2019#use-the-command-line-to-create-a-local-cache


```
.\vs_buildtools__1736098771.1589929105.exe `
--add Microsoft.VisualStudio.Workload.DataBuildTools `
--add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools `
--add Microsoft.VisualStudio.Workload.MSBuildTools `
--add Microsoft.VisualStudio.Workload.NetCoreBuildTools `
--add Microsoft.VisualStudio.Workload.UniversalBuildTools `
--add Microsoft.VisualStudio.Workload.VCTools `
--add Microsoft.VisualStudio.Workload.WebBuildTools `
--includeRecommended  --includeOptional `
--lang en-US `
--layout c:\vslayout
```

So to install run the following commands:


```
.\vs_buildtools__1736098771.1589929105.exe `
--add Microsoft.VisualStudio.Workload.DataBuildTools `
--add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools `
--add Microsoft.VisualStudio.Workload.MSBuildTools `
--add Microsoft.VisualStudio.Workload.NetCoreBuildTools `
--add Microsoft.VisualStudio.Workload.UniversalBuildTools `
--add Microsoft.VisualStudio.Workload.VCTools `
--add Microsoft.VisualStudio.Workload.WebBuildTools `
--includeRecommended  --includeOptional
```
