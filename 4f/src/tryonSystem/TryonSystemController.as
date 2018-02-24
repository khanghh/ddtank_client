package tryonSystem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class TryonSystemController
   {
      
      private static var _instance:TryonSystemController;
       
      
      private var _view:Frame;
      
      private var _modelDic:Dictionary;
      
      private var _sumbmintFunDic:Dictionary;
      
      private var _cancelFunDic:Dictionary;
      
      public function TryonSystemController(){super();}
      
      public static function get Instance() : TryonSystemController{return null;}
      
      public function getModelByView(param1:Frame) : TryonModel{return null;}
      
      public function get view() : Frame{return null;}
      
      public function show(param1:Array, param2:Function = null, param3:Function = null) : void{}
      
      private function __onRemoved(param1:Event) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
   }
}
