using System.Collections.ObjectModel;
using Soundchaser.TagTools.Maui.Models;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class PaneViewModel : BaseViewModel
{
    public string Title { get; set; } = string.Empty;
    public PaneKind Kind { get; set; }
    public ObservableCollection<PaneItemViewModel> Items { get; } = new();

    private PaneItemViewModel? _selectedItem;
    public PaneItemViewModel? SelectedItem
    {
        get => _selectedItem;
        set { _selectedItem = value; OnPropertyChanged(); }
    }
}
