using Soundchaser.TagTools.Maui.Models;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class DatabaseDetailsPaneViewModel : PaneViewModel
{
    public DatabaseDetailsPaneViewModel(string databaseName)
    {
        Kind = PaneKind.DatabaseDetails;
        Title = databaseName;
        Items.Add(new PaneItemViewModel { Name = "Rock", Kind = PaneItemKind.Folder });
        Items.Add(new PaneItemViewModel { Name = "Jazz", Kind = PaneItemKind.Folder });
        Items.Add(new PaneItemViewModel { Name = "Classical", Kind = PaneItemKind.Folder });
        Items.Add(new PaneItemViewModel { Name = "Electronic", Kind = PaneItemKind.Folder });
    }
}
