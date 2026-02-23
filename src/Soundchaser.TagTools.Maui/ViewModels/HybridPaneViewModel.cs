using Soundchaser.TagTools.Maui.Models;
using Soundchaser.TagTools.Maui.Resources.Strings;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class HybridPaneViewModel : PaneViewModel
{
    public HybridPaneViewModel()
    {
        Kind = PaneKind.Hybrid;
        Title = AppStrings.PaneTitleDatabases;
        Items.Add(new PaneItemViewModel { Name = "Local Library", Kind = PaneItemKind.Database });
        Items.Add(new PaneItemViewModel { Name = "Backup Library", Kind = PaneItemKind.Database, AttentionState = AttentionState.Warning });
        Items.Add(new PaneItemViewModel { Name = "Archive", Kind = PaneItemKind.Database, AttentionState = AttentionState.Error });
    }
}
