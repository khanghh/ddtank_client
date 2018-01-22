package christmas
{
   import baglocked.BaglockedManager;
   import christmas.controller.ChristmasRoomController;
   import christmas.event.ChrismasEvent;
   import christmas.event.ChristmasRoomEvent;
   import christmas.info.ChristmasSystemItemsInfo;
   import christmas.items.ExpBar;
   import christmas.loader.LoaderChristmasUIModule;
   import christmas.manager.ChristmasMonsterManager;
   import christmas.model.ChristmasModel;
   import christmas.view.ChristmasChooseRoomFrame;
   import christmas.view.makingSnowmenView.ChristmasMakingSnowmenFrame;
   import christmas.view.makingSnowmenView.SnowPackDoubleFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class ChristmasCoreController extends EventDispatcher
   {
      
      private static var _instance:ChristmasCoreController;
      
      public static var isToRoom:Boolean;
      
      public static var isFrameChristmas:Boolean;
       
      
      private var _model:ChristmasModel;
      
      private var _hallStateView:HallStateView;
      
      private var _makingSnoFrame:ChristmasMakingSnowmenFrame;
      
      private var _appearPos:Array;
      
      private var _snowPackDoubleFrame:SnowPackDoubleFrame;
      
      private var _outFun:Function;
      
      public var isReConnect:Boolean = false;
      
      public var loadUiModuleComplete:Boolean = false;
      
      private var _manager:ChristmasCoreManager;
      
      private var _chooseRoomFrame:ChristmasChooseRoomFrame;
      
      public function ChristmasCoreController(param1:PrivateClass)
      {
         _appearPos = [];
         ChristmasRoomController;
         _manager = ChristmasCoreManager.instance;
         _model = _manager.model;
         super();
      }
      
      public static function get instance() : ChristmasCoreController
      {
         if(ChristmasCoreController._instance == null)
         {
            ChristmasCoreController._instance = new ChristmasCoreController(new PrivateClass());
         }
         return ChristmasCoreController._instance;
      }
      
      public function setup() : void
      {
         addEvents();
      }
      
      private function addEvents() : void
      {
         _manager.addEventListener("xmas_show",onEvent);
         _manager.addEventListener("xmas_playing_snowman",onEvent);
         _manager.addEventListener("xmas_reconnect_christmas",onEvent);
         _manager.addEventListener("xmas_reconnect",onEvent);
         _manager.addEventListener("xmas_snow_is_update",onEvent);
         _manager.addEventListener("xmas_snowman_enter",onEvent);
         _manager.addEventListener("xmas_click_christmas_icon",onEvent);
         _manager.addEventListener("xmas_dispose_enter_icon",onEvent);
         _manager.addEventListener("xmas_game_start",onEvent);
      }
      
      private function onEvent(param1:ChrismasEvent) : void
      {
         var _loc2_:* = param1.type;
         if("xmas_show" !== _loc2_)
         {
            if("xmas_playing_snowman" !== _loc2_)
            {
               if("xmas_reconnect_christmas" !== _loc2_)
               {
                  if("xmas_reconnect" !== _loc2_)
                  {
                     if("xmas_snow_is_update" !== _loc2_)
                     {
                        if("xmas_snowman_enter" !== _loc2_)
                        {
                           if("xmas_click_christmas_icon" !== _loc2_)
                           {
                              if("xmas_dispose_enter_icon" !== _loc2_)
                              {
                                 if("xmas_game_start" === _loc2_)
                                 {
                                    ChristmasMonsterManager.Instance.__gameStart(null);
                                 }
                              }
                              else
                              {
                                 disposeEnterIcon();
                              }
                           }
                           else
                           {
                              _onClickChristmasIcon();
                           }
                        }
                        else
                        {
                           makingSnowmanEnter();
                        }
                     }
                     else
                     {
                        snowIsUpdata(param1.data as ChristmasSystemItemsInfo);
                     }
                  }
                  else
                  {
                     reConnect();
                  }
               }
               else
               {
                  reConnectChristmasFunc();
               }
            }
            else
            {
               playingSnowmanEnter();
            }
         }
         else
         {
            enterChristmasGame(param1.data as PackageIn);
         }
      }
      
      private function enterChristmasGame(param1:PackageIn) : void
      {
         _manager._goods = ShopManager.Instance.getGoodsByTemplateID(201145,1);
         _model.isEnter = param1.readBoolean();
         if(_model.isEnter)
         {
            _model.gameBeginTime = param1.readDate();
            _model.gameEndTime = param1.readDate();
            _model.count = param1.readInt();
            playingSnowmanEnter();
         }
         else
         {
            showTransactionFrame(LanguageMgr.GetTranslation("christmas.buy.playingSnowman.volumes",_manager._goods.AValue1),buyPlayingSnowmanVolumes,null,null,false,false,1);
         }
      }
      
      protected function __alertBuyTime(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertBuyTime);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               if(_loc3_.isBand)
               {
                  if(!checkMoney(true))
                  {
                     _loc3_.dispose();
                     _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     _loc2_.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(!checkMoney(false))
               {
                  _loc3_.dispose();
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  return;
               }
               buyPlayingSnowmanVolumes(_loc3_.isBand);
               break;
         }
         _loc3_.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               return;
            }
            buyPlayingSnowmanVolumes(false);
         }
         param1.currentTarget.dispose();
      }
      
      private function buyPlayingSnowmanVolumes(param1:Boolean) : void
      {
         SocketManager.Instance.out.sendBuyPlayingSnowmanVolumes(param1);
      }
      
      public function playingSnowmanEnter() : void
      {
         _manager.mapPath = LoaderChristmasUIModule.Instance.getChristmasResource() + "/map/ChristmasMap.swf";
         _manager.christmasInfo.playerDefaultPos = new Point(500,500);
         _manager.christmasInfo.myPlayerVO.playerPos = _manager.christmasInfo.playerDefaultPos;
         _manager.christmasInfo.myPlayerVO.playerStauts = 0;
         LoaderChristmasUIModule.Instance.loadMap();
      }
      
      public function reConnectChristmasFunc() : void
      {
         if(ChristmasCoreManager.isTimeOver)
         {
            ChristmasCoreManager.isTimeOver = false;
            StateManager.setState("main");
            return;
         }
         ChristmasCoreController.isToRoom = true;
         if(!loadUiModuleComplete)
         {
            reConnect();
         }
         else
         {
            isReConnect = false;
            StateManager.setState("christmasroom");
         }
      }
      
      public function reConnect() : void
      {
         isReConnect = true;
         LoaderChristmasUIModule.Instance.loadUIModule(reConnectLoadUiComplete);
      }
      
      private function reConnectLoadUiComplete() : void
      {
         loadUiModuleComplete = true;
         SocketManager.Instance.out.enterChristmasRoomIsTrue();
      }
      
      private function snowIsUpdata(param1:ChristmasSystemItemsInfo) : void
      {
         if(_makingSnoFrame)
         {
            _makingSnoFrame.upDatafitCount();
            _makingSnoFrame.snowmenAction(param1);
            _manager.dispatchEvent(new ChristmasRoomEvent("score_convert"));
         }
      }
      
      private function makingSnowmanEnter() : void
      {
         _makingSnoFrame = ComponentFactory.Instance.creatComponentByStylename("chooseRoom.christmas.ChristmasMakingSnowmenFrame");
         LayerManager.Instance.addToLayer(_makingSnoFrame,3,true,1);
      }
      
      public function getBagSnowPacksCount() : int
      {
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         var _loc1_:BagInfo = _loc3_.getBag(1);
         var _loc2_:int = _loc1_.getItemCountByTemplateId(201144);
         return _loc2_;
      }
      
      public function _onClickChristmasIcon() : void
      {
         LoaderChristmasUIModule.Instance.loadUIModule(doOpenChristmasFrame);
      }
      
      private function doOpenChristmasFrame() : void
      {
         loadUiModuleComplete = true;
         if(_manager._isShowIcon)
         {
            _chooseRoomFrame = ComponentFactory.Instance.creatComponentByStylename("chooseRoom.christmas.ChristmasChooseRoomFrame");
            LayerManager.Instance.addToLayer(_chooseRoomFrame,3,true,1);
         }
      }
      
      public function get makingSnowmenFrame() : ChristmasMakingSnowmenFrame
      {
         return _makingSnoFrame;
      }
      
      public function get expBar() : ExpBar
      {
         return _makingSnoFrame.expBar;
      }
      
      public function get christmasInfo() : ChristmasSystemItemsInfo
      {
         return _manager.christmasInfo;
      }
      
      public function getCount() : int
      {
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         var _loc1_:BagInfo = _loc3_.getBag(1);
         var _loc2_:int = _loc1_.getItemCountByTemplateId(201144);
         return _loc2_;
      }
      
      public function showTransactionFrame(param1:String, param2:Function = null, param3:Function = null, param4:Sprite = null, param5:Boolean = true, param6:Boolean = false, param7:int = 0) : void
      {
         _snowPackDoubleFrame = ComponentFactory.Instance.creatComponentByStylename("christmas.views.SnowPackDoubleFrame");
         _snowPackDoubleFrame.buyFunction = param2;
         _snowPackDoubleFrame.clickFunction = param3;
         _snowPackDoubleFrame.setIsShow(param5,param7);
         _snowPackDoubleFrame.setTxt(param1);
         _snowPackDoubleFrame.initAddView(param6);
         _snowPackDoubleFrame.target = param4;
         LayerManager.Instance.addToLayer(_snowPackDoubleFrame,3,true,2);
      }
      
      public function checkMoney(param1:Boolean) : Boolean
      {
         if(param1)
         {
            if(PlayerManager.Instance.Self.BandMoney < _manager._goods.AValue1)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < _manager._goods.AValue1)
         {
            return false;
         }
         return true;
      }
      
      public function disposeEnterIcon() : void
      {
         if(_makingSnoFrame)
         {
            _makingSnoFrame.dispose();
            _makingSnoFrame = null;
         }
         if(_chooseRoomFrame)
         {
            _chooseRoomFrame.dispose();
            _chooseRoomFrame = null;
         }
      }
      
      public function returnComponentBnt(param1:BaseButton, param2:String) : Component
      {
         var _loc3_:Component = new Component();
         _loc3_.tipData = param2;
         _loc3_.tipDirctions = "0,1,2";
         _loc3_.tipStyle = "ddt.view.tips.OneLineTip";
         _loc3_.tipGapH = 20;
         _loc3_.width = param1.width;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         param1.x = 0;
         param1.y = 0;
         _loc3_.addChild(param1);
         return _loc3_;
      }
      
      public function exitGame() : void
      {
         GameInSocketOut.sendGamePlayerExit();
      }
      
      public function CanGetGift(param1:int) : Boolean
      {
         return (ChristmasCoreController.instance.model.awardState >> param1 & 1) == 0;
      }
      
      public function get model() : ChristmasModel
      {
         return this._model;
      }
      
      public function get mapPath() : String
      {
         return _manager.mapPath;
      }
      
      public function get canMakeSnowMen() : Boolean
      {
         return _manager.canMakeSnowMen;
      }
      
      public function set canMakeSnowMen(param1:Boolean) : void
      {
         _manager.canMakeSnowMen = param1;
      }
      
      public function get christmasIcon() : MovieClip
      {
         return _manager.christmasIcon;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
