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
      
      public function YYVipManager(target:IEventDispatcher = null)
      {
         super(target);
         awardList = new DictionaryData();
         var _loc4_:int = 0;
         var _loc3_:* = award_id_list;
         for each(var id in award_id_list)
         {
            awardList.add(id,[]);
         }
      }
      
      public static function get isShowOpenView() : Boolean
      {
         return YY_VIP_SHOW_OPEN_VIEW == 1;
      }
      
      public static function get isShowEntryBtn() : Boolean
      {
         return YY_VIP_TAG == 1;
      }
      
      public static function get instance() : YYVipManager
      {
         if(_instance == null)
         {
            _instance = new YYVipManager();
         }
         return _instance;
      }
      
      public function loadResModule() : void
      {
         show();
      }
      
      public function show() : void
      {
         dispatchEvent(new CEvent("yyvipOpenView"));
      }
      
      public function createEntryBtn(hBox:HBox) : void
      {
         if(isShowEntryBtn)
         {
            _entryBtn = new YYVipEntryBtn();
            hBox.addChild(_entryBtn);
         }
      }
      
      public function disposeEntryBtn() : void
      {
         ObjectUtils.disposeObject(_entryBtn);
         _entryBtn = null;
      }
   }
}
