package org.reporterslab.archiver.views.utils
{
	import flash.text.StyleSheet;

	public class StyleUtils
	{
		
		public function StyleUtils()
		{
		}
		
		
		public static function get htmlStyles():StyleSheet
		{
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( "a:hover { color: #FFCC00; text-decoration: underline; } a { color: #778E1E; text-decoration:none; }" );
			return styleSheet;
		}
		
		
		
	}
}