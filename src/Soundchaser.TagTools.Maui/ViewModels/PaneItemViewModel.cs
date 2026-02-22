using Soundchaser.TagTools.Maui.Models;

namespace Soundchaser.TagTools.Maui.ViewModels;

public class PaneItemViewModel : BaseViewModel
{
    public string Name { get; set; } = string.Empty;
    public PaneItemKind Kind { get; set; }
    public AttentionState AttentionState { get; set; } = AttentionState.Normal;

    private bool _isSelected;
    public bool IsSelected
    {
        get => _isSelected;
        set { _isSelected = value; OnPropertyChanged(); }
    }
}
