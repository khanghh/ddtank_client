package dice.event
{
   import flash.events.Event;
   
   public class DiceEvent extends Event
   {
      
      public static const ACTIVE_CLOSE:String = "dice_active_close";
      
      public static const RETURN_DICE:String = "dice_return";
      
      public static const REFRESH_DATA:String = "dice_refresh_data";
      
      public static const GET_DICE_RESULT_DATA:String = "get_dice_result_data";
      
      public static const CHANGED_LUCKINTEGRAL_LEVEL:String = "dice_level_changed";
      
      public static const CHANGED_LUCKINTEGRAL:String = "dice_luckintegral_changed";
      
      public static const CHANGED_FREE_COUNT:String = "dice_freeCount_changed";
      
      public static const CHANGED_PLAYER_POSITION:String = "dice_position_changed";
      
      public static const CHANGED_DICETYPE:String = "dice_type_changed";
      
      public static const PLAYER_ISWALKING:String = "dice_player_iswalking";
      
      public static const MOVIE_FINISH:String = "movie_finish";
      
      public static const SHOWMAINVIEW:String = "showMainView";
       
      
      public var resultData:Object;
      
      public function DiceEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
