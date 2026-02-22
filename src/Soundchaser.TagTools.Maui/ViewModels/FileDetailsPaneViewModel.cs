using Soundchaser.TagTools.Maui.Models;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class FileDetailsPaneViewModel : PaneViewModel
{
    public FileDetailsPaneViewModel(string folderName)
    {
        Kind = PaneKind.FileDetails;
        Title = folderName;
        Items.Add(new PaneItemViewModel { Name = "Track 01 - Opening.mp3", Kind = PaneItemKind.Track });
        Items.Add(new PaneItemViewModel { Name = "Track 02 - Journey.flac", Kind = PaneItemKind.Track, AttentionState = AttentionState.Warning });
        Items.Add(new PaneItemViewModel { Name = "Track 03 - Finale.mp3", Kind = PaneItemKind.Track });
    }
}
