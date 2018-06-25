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
      
      public function PyramidManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function templateDataSetup(dataList:Array) : void
      {
         PyramidManager.instance.model.items = dataList;
      }
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event.cmd;
         switch(int(cmd))
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               iconEnter(pkg);
               break;
            case 2:
               dispatchEvent(new PyramidEvent("start_or_stop",null,pkg));
               break;
            case 3:
               dispatchEvent(new PyramidEvent("card_result",null,pkg));
               break;
            case 4:
               dispatchEvent(new PyramidEvent("die_event",null,pkg));
               break;
            case 5:
               dispatchEvent(new PyramidEvent("score_convert",null,pkg));
         }
      }
      
      protected function iconEnter(pkg:PackageIn) : void
      {
         var layer:int = 0;
         var i:int = 0;
         var tempLayer:int = 0;
         var count:int = 0;
         var j:int = 0;
         var templateID:int = 0;
         var position:int = 0;
         model.isUp = false;
         model.currentLayer = pkg.readInt();
         model.maxLayer = pkg.readInt();
         model.totalPoint = pkg.readInt();
         model.turnPoint = pkg.readInt();
         model.pointRatio = pkg.readInt();
         model.currentFreeCount = pkg.readInt();
         model.currentReviveCount = pkg.readInt();
         model.isPyramidStart = pkg.readBoolean();
         if(model.isPyramidStart)
         {
            layer = pkg.readInt();
            model.selectLayerItems = new Dictionary();
            for(i = 1; i <= layer; )
            {
               tempLayer = pkg.readInt();
               model.selectLayerItems[tempLayer] = new Dictionary();
               count = pkg.readInt();
               for(j = 0; j < count; )
               {
                  templateID = pkg.readInt();
                  position = pkg.readInt();
                  model.selectLayerItems[tempLayer][position] = templateID;
                  j++;
               }
               i++;
            }
         }
         if(StateManager.currentStateType != "pyramid")
         {
            StateManager.setState("pyramid");
         }
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         var revivePriceCount:int = 0;
         var i:int = 0;
         model.isOpen = pkg.readBoolean();
         model.isScoreExchange = pkg.readBoolean();
         if(model.isOpen)
         {
            model.beginTime = pkg.readDate();
            model.endTime = pkg.readDate();
            model.freeCount = pkg.readInt();
            model.turnCardPrice = pkg.readInt();
            model.revivePrice = [];
            revivePriceCount = pkg.readInt();
            for(i = 0; i < revivePriceCount; )
            {
               model.revivePrice.push(pkg.readInt());
               i++;
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
      
      public function onClickPyramidIcon(event:MouseEvent) : void
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
      
      protected function __onPyramidClick(event:MouseEvent) : void
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
