using Soundchaser.TagTools.Maui.Models;
using Soundchaser.TagTools.Maui.ViewModels;

namespace Soundchaser.TagTools.Maui.Views.Panes;

public class PaneTemplateSelector : DataTemplateSelector
{
    public DataTemplate? HybridTemplate { get; set; }
    public DataTemplate? DatabaseDetailsTemplate { get; set; }
    public DataTemplate? FileDetailsTemplate { get; set; }

    protected override DataTemplate? OnSelectTemplate(object item, BindableObject container)
    {
        return item switch
        {
            HybridPaneViewModel          => HybridTemplate,
            DatabaseDetailsPaneViewModel => DatabaseDetailsTemplate,
            FileDetailsPaneViewModel     => FileDetailsTemplate,
            _                            => HybridTemplate
        };
    }
}
