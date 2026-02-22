using System.Globalization;
using Soundchaser.TagTools.Maui.Models;

namespace Soundchaser.TagTools.Maui.Converters;

public class AttentionStateToColorConverter : IValueConverter
{
    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        return value is AttentionState state
            ? state switch
            {
                AttentionState.Warning => Color.FromArgb("#FFF3CD"),
                AttentionState.Error   => Color.FromArgb("#F8D7DA"),
                _                      => Colors.Transparent
            }
            : Colors.Transparent;
    }

    public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
        => throw new NotImplementedException();
}
