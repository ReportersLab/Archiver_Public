package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.views.components.SearchPanel;
	import org.reporterslab.archiver.views.components.StatusList;
	import org.reporterslab.archiver.views.components.TwitterLogin;
	import org.reporterslab.archiver.views.mediators.ApplicationMediator;
	import org.reporterslab.archiver.views.mediators.SearchPanelMediator;
	import org.reporterslab.archiver.views.mediators.StatusListMediator;
	import org.reporterslab.archiver.views.mediators.TwitterLoginMediator;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureViewCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			trace("Configuring Views");
			//configure the views. Basically linking Mediators to Views.
			mediatorMap.mapView(Archiver, ApplicationMediator);
			mediatorMap.mapView(StatusList, StatusListMediator);
			mediatorMap.mapView(SearchPanel, SearchPanelMediator);
			mediatorMap.mapView(TwitterLogin, TwitterLoginMediator);
		}
		
	}
}