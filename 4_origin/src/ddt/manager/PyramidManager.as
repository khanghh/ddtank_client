package ddt.manager
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.PyramidModel;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PyramidEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class PyramidManager extends EventDispatcher
   {
      
      private static var _instance:PyramidManager;
       
      
      private var _model:PyramidModel;
      
      private var _isShowIcon:Boolean = false;
      
      private var _pyramidBtn:BaseButton;
      
      private var _hall:HallStateView;
      
      public function PyramidManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : PyramidManager
      {
         if(!_instance)
         {
            _instance = new PyramidManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new PyramidModel();
         SocketManager.Instance.addEventListener("pyramid_system",pkgHandler);
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         PyramidManager.instance.model.items = param1;
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1.cmd;
         switch(int(_loc2_))
         {
            case 0:
               openOrclose(_loc3_);
               break;
            case 1:
               iconEnter(_loc3_);
               break;
            case 2:
               dispatchEvent(new PyramidEvent("start_or_stop",null,_loc3_));
               break;
            case 3:
               dispatchEvent(new PyramidEvent("card_result",null,_loc3_));
               break;
            case 4:
               dispatchEvent(new PyramidEvent("die_event",null,_loc3_));
               break;
            case 5:
               dispatchEvent(new PyramidEvent("score_convert",null,_loc3_));
         }
      }
      
      protected function iconEnter(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         model.isUp = false;
         model.currentLayer = param1.readInt();
         model.maxLayer = param1.readInt();
         model.totalPoint = param1.readInt();
         model.turnPoint = param1.readInt();
         model.pointRatio = param1.readInt();
         model.currentFreeCount = param1.readInt();
         model.currentReviveCount = param1.readInt();
         model.isPyramidStart = param1.readBoolean();
         if(model.isPyramidStart)
         {
            _loc5_ = param1.readInt();
            model.selectLayerItems = new Dictionary();
            _loc8_ = 1;
            while(_loc8_ <= _loc5_)
            {
               _loc6_ = param1.readInt();
               model.selectLayerItems[_loc6_] = new Dictionary();
               _loc4_ = param1.readInt();
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc3_ = param1.readInt();
                  _loc2_ = param1.readInt();
                  model.selectLayerItems[_loc6_][_loc2_] = _loc3_;
                  _loc7_++;
               }
               _loc8_++;
            }
         }
         if(StateManager.currentStateType != "pyramid")
         {
            StateManager.setState("pyramid");
         }
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         model.isOpen = param1.readBoolean();
         model.isScoreExchange = param1.readBoolean();
         if(model.isOpen)
         {
            model.beginTime = param1.readDate();
            model.endTime = param1.readDate();
            model.freeCount = param1.readInt();
            model.turnCardPrice = param1.readInt();
            model.revivePrice = [];
            _loc2_ = param1.readInt();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               model.revivePrice.push(param1.readInt());
               _loc3_++;
            }
         }
         if(model.isOpen)
         {
            showEnterIcon();
         }
         else
         {
            hideEnterIcon();
            if(StateManager.currentStateType == "pyramid")
            {
               StateManager.setState("main");
            }
         }
      }
      
      public function onClickPyramidIcon(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendRequestEnterPyramidSystem();
         if(StateManager.currentStateType != "pyramid")
         {
            StateManager.setState("pyramid");
         }
      }
      
      public function showEnterIcon() : void
      {
         _isShowIcon = true;
         if(PlayerManager.Instance.Self.Grade >= 13)
         {
            HallIconManager.instance.updateSwitchHandler("pyramid",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("pyramid",true,13);
         }
      }
      
      protected function __onPyramidClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.enterPyramid();
      }
      
      public function hideEnterIcon() : void
      {
         _isShowIcon = false;
         HallIconManager.instance.updateSwitchHandler("pyramid",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("pyramid",false);
      }
      
      public function get model() : PyramidModel
      {
         return this._model;
      }
      
      public function get pyramidBtn() : BaseButton
      {
         return _pyramidBtn;
      }
   }
}
