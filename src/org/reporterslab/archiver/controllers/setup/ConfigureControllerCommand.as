package org.reporterslab.archiver.controllers.setup
{
	import flash.events.Event;
	
	import mx.core.Application;
	
	import org.reporterslab.archiver.controllers.SaveContentCommand;
	import org.reporterslab.archiver.controllers.SearchCommand;
	import org.reporterslab.archiver.controllers.SelectEntityCommand;
	import org.reporterslab.archiver.controllers.SelectPlaceCommand;
	import org.reporterslab.archiver.controllers.SelectStatusCommand;
	import org.reporterslab.archiver.controllers.SelectUserCommand;
	import org.reporterslab.archiver.controllers.UpdateServicesCommand;
	import org.reporterslab.archiver.controllers.db.LoadedStatusesCommand;
	import org.reporterslab.archiver.controllers.db.PlacesSearchedCommand;
	import org.reporterslab.archiver.controllers.db.StatusesSearchedCommand;
	import org.reporterslab.archiver.controllers.db.UsersSearchedCommand;
	import org.reporterslab.archiver.controllers.system.ApplicationExitingCommand;
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.events.ArchiverContentEvent;
	import org.reporterslab.archiver.events.ArchiverDBPlaceEvent;
	import org.reporterslab.archiver.events.ArchiverDBStatusEvent;
	import org.reporterslab.archiver.events.ArchiverDBUserEvent;
	import org.reporterslab.archiver.events.ArchiverEntityEvent;
	import org.reporterslab.archiver.events.ArchiverPlaceEvent;
	import org.reporterslab.archiver.events.ArchiverSearchEvent;
	import org.reporterslab.archiver.events.ArchiverStatusEvent;
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.events.ArchiverUpdaterEvent;
	import org.reporterslab.archiver.events.ArchiverUserEvent;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureControllerCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			//configure the controllers.
			trace("Configuring the Controller.");
		
			commandMap.mapEvent(ArchiverContentEvent.NEW_CONTENT, SaveContentCommand, ArchiverContentEvent);
			commandMap.mapEvent(ArchiverUpdaterEvent.UPDATE, UpdateServicesCommand, ArchiverUpdaterEvent);
			
			//database events
			commandMap.mapEvent(ArchiverDBStatusEvent.STATUSES_LOADED, LoadedStatusesCommand, ArchiverDBStatusEvent); 
			commandMap.mapEvent(ArchiverDBStatusEvent.STATUSES_SEARCHED, StatusesSearchedCommand, ArchiverDBStatusEvent);
			commandMap.mapEvent(ArchiverDBUserEvent.USERS_SEARCHED, UsersSearchedCommand, ArchiverDBUserEvent);
			commandMap.mapEvent(ArchiverDBPlaceEvent.PLACES_SEARCHED, PlacesSearchedCommand, ArchiverDBPlaceEvent);
			
			//system wide events
			commandMap.mapEvent(Event.EXITING, ApplicationExitingCommand, Event);
			
			
			//commands triggered from view interactions.
			commandMap.mapEvent(ArchiverStatusEvent.STATUS_SELECTED, SelectStatusCommand, ArchiverStatusEvent);
			commandMap.mapEvent(ArchiverUserEvent.USER_SELECTED, SelectUserCommand, ArchiverUserEvent);
			commandMap.mapEvent(ArchiverPlaceEvent.PLACE_SELECTED, SelectPlaceCommand, ArchiverPlaceEvent);
			commandMap.mapEvent(ArchiverEntityEvent.ENTITY_SELECTED, SelectEntityCommand, ArchiverEntityEvent);
			commandMap.mapEvent(ArchiverSearchEvent.SEARCH, SearchCommand, ArchiverSearchEvent);
			
			//Configure the Service
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_DATABASE));
		}
		
		
	}
}