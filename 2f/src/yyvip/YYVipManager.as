package yyvip
{
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   import yyvip.view.YYVipEntryBtn;
   
   public class YYVipManager extends EventDispatcher
   {
      
      public static const YYVIP_OPENVIEW:String = "yyvipOpenView";
      
      public static var YY_VIP_TAG:int;
      
      public static var VIP_OPEN_URL:String;
      
      public static var YY_VIP_SHOW_OPEN_VIEW:int;
      
      private static var _instance:YYVipManager;
       
      
      public const award_id_list:Array = [112315,112316,112317,112318,112319,112320,112321,1120342,112322];
      
      public var awardList:DictionaryData;
      
      private var _entryBtn:YYVipEntryBtn;
      
      public function YYVipManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get isShowOpenView() : Boolean{return false;}
      
      public static function get isShowEntryBtn() : Boolean{return false;}
      
      public static function get instance() : YYVipManager{return null;}
      
      public function loadResModule() : void{}
      
      public function show() : void{}
      
      public function createEntryBtn(param1:HBox) : void{}
      
      public function disposeEntryBtn() : void{}
   }
}
