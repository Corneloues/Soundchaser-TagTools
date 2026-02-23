using System.Globalization;
using Soundchaser.TagTools.Maui.Models;

namespace Soundchaser.TagTools.Maui.Converters;

public class AttentionStateToColorConverter : IValueConverter
{
    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        if (value is not AttentionState state)
            return Colors.Transparent;

        var key = state switch
        {
            AttentionState.Warning => "AttentionWarning",
            AttentionState.Error   => "AttentionError",
            _                      => null
        };

        if (key is null)
            return Colors.Transparent;

        return Application.Current?.Resources.TryGetValue(key, out var color) == true
            ? color
            : Colors.Transparent;
    }

    public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
        => throw new NotImplementedException();
}
