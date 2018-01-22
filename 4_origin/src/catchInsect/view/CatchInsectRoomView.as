package catchInsect.view
{
   import baglocked.BaglockedManager;
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.CatchInsectRoomModel;
   import catchInsect.componets.RoomMenuView;
   import catchInsect.event.CatchInsectRoomEvent;
   import catchInsect.loader.LoaderCatchInsectUIModule;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class CatchInsectRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZEII:Array = [1738,1300];
       
      
      private var _contoller:CatchInsectRoomController;
      
      private var _model:CatchInsectRoomModel;
      
      private var _sceneScene:SceneScene;
      
      private var _sceneMap:CatchInsectScneneMap;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _sceneInfoViewBg:Bitmap;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _ballCountTxt:FilterFrameText;
      
      private var _netCountTxt:FilterFrameText;
      
      private var _buyBallBtn:SimpleBitmapButton;
      
      private var _buyNetBtn:SimpleBitmapButton;
      
      private var _useCakeBtn:SimpleBitmapButton;
      
      private var _useWhistleBtn:SimpleBitmapButton;
      
      private var _useCakeTxt:FilterFrameText;
      
      private var _useWhistleTxt:FilterFrameText;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _timer:Timer;
      
      public function CatchInsectRoomView(param1:CatchInsectRoomController, param2:CatchInsectRoomModel)
      {
         super();
         this._contoller = param1;
         this._model = param2;
         initialize();
         SocketManager.Instance.out.updateInsectInfo();
      }
      
      public function show() : void
      {
         _contoller.addChild(this);
      }
      
      private function initialize() : void
      {
         SoundManager.instance.playMusic("12028");
         _sceneScene = new SceneScene();
         ChatManager.Instance.state = 32;
         _chatFrame = ChatManager.Instance.view;
         _chatFrame.output.isLock = true;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
         _sceneInfoViewBg = ComponentFactory.Instance.creatBitmap("catchInsect.room.infoView");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.scene.infoTxt");
         _ballCountTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.scene.infoTxt");
         PositionUtils.setPos(_ballCountTxt,"catchInsect.ballCountTxtPos");
         _netCountTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.scene.infoTxt");
         PositionUtils.setPos(_netCountTxt,"catchInsect.netCountTxtPos");
         _buyBallBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.buyBallBtn");
         _buyNetBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.buyNetBtn");
         _useCakeBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.useCakeBtn");
         _useCakeBtn.tipData = LanguageMgr.GetTranslation("catchInsect.uangAppear");
         _useCakeTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.useCakeTxt");
         _useCakeBtn.addChild(_useCakeTxt);
         _useWhistleBtn = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.useWhistleBtn");
         _useWhistleBtn.enable = !CatchInsectControl.instance.isRefreshMonster;
         _useWhistleBtn.tipData = LanguageMgr.GetTranslation("catchInsect.whistleTipMsg");
         _useWhistleTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.room.useCakeTxt");
         _useWhistleBtn.addChild(_useWhistleTxt);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"catchInsect.HelpButton",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),"catchInsect.helpTxt",504,484);
         PositionUtils.setPos(_helpBtn,"catchInsect.HelpButtonPos");
         _scoreTxt.text = CatchInsectManager.instance.model.score.toString();
         _ballCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10615).toString();
         _netCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10616).toString();
         addChild(_sceneInfoViewBg);
         addChild(_scoreTxt);
         addChild(_buyBallBtn);
         addChild(_buyNetBtn);
         addChild(_useCakeBtn);
         addChild(_useWhistleBtn);
         addChild(_ballCountTxt);
         addChild(_netCountTxt);
         addChild(_helpBtn);
         _roomMenuView = ComponentFactory.Instance.creat("catchInsect.room.menuView");
         addChild(_roomMenuView);
         _roomMenuView.addEventListener("close",_leaveRoom);
         setMap();
         addEvent();
         updateBtnTxt();
      }
      
      private function addEvent() : void
      {
         _buyBallBtn.addEventListener("click",__buyBallBtnClick);
         _buyNetBtn.addEventListener("click",__buyNetBtnClick);
         _useCakeBtn.addEventListener("click",__useCakeBtnClick);
         _useWhistleBtn.addEventListener("click",__useWhistleBtnClick);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateGoods);
         CatchInsectManager.instance.addEventListener("updateInfo",__updateScore);
         CatchInsectManager.instance.addEventListener("updatefightMonster",__updateFightMonster);
      }
      
      private function updateBtnTxt() : void
      {
         var _loc2_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11958);
         var _loc1_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11968);
         _useCakeTxt.text = _loc2_ + "";
         _useWhistleTxt.text = _loc1_ + "";
         _useCakeTxt.visible = _loc2_ < 1?false:true;
         _useWhistleTxt.visible = _loc1_ < 1?false:true;
      }
      
      private function __updateFightMonster(param1:CatchInsectRoomEvent) : void
      {
         if(_useWhistleBtn)
         {
            _useWhistleBtn.enable = !CatchInsectControl.instance.isRefreshMonster;
         }
      }
      
      protected function __useCakeBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11958);
         if(_loc3_)
         {
            SocketManager.Instance.out.sendUseCard(_loc3_.BagType,_loc3_.Place,[_loc3_.TemplateID],_loc3_.PayType);
            SocketManager.Instance.out.requestCakeStatus();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("catchInsect.noCake"));
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _loc2_.itemID = 11958;
            LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         }
      }
      
      protected function __useWhistleBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11968);
         if(_loc3_)
         {
            SocketManager.Instance.out.requestInsectWhistleUse(11968);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("catchInsect.noWhistle"));
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("catchInsect.QuickFrame");
            _loc2_.itemID = 11968;
            _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         }
      }
      
      protected function __updateScore(param1:Event) : void
      {
         var _loc2_:int = CatchInsectManager.instance.model.score;
         var _loc3_:int = CatchInsectManager.instance.model.avaibleScore;
         _scoreTxt.text = _loc3_.toString();
      }
      
      private function removeEvent() : void
      {
         _buyBallBtn.removeEventListener("click",__buyBallBtnClick);
         _buyNetBtn.removeEventListener("click",__buyNetBtnClick);
         _useCakeBtn.removeEventListener("click",__useCakeBtnClick);
         _useWhistleBtn.removeEventListener("click",__useWhistleBtnClick);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateGoods);
         CatchInsectManager.instance.removeEventListener("updateInfo",__updateScore);
         CatchInsectManager.instance.removeEventListener("updatefightMonster",__updateFightMonster);
      }
      
      protected function __updateGoods(param1:BagEvent) : void
      {
         _ballCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10615).toString();
         _netCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10616).toString();
         updateBtnTxt();
      }
      
      protected function __buyNetBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc2_.itemID = 10616;
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      protected function __buyBallBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc2_.itemID = 10615;
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      public function setViewAgain() : void
      {
         SoundManager.instance.playMusic("12028");
         ChatManager.Instance.state = 32;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
         _chatFrame.output.isLock = true;
         _sceneMap.enterIng = false;
         SocketManager.Instance.out.updateInsectInfo();
      }
      
      public function setMap(param1:Point = null) : void
      {
         clearMap();
         var _loc6_:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(LoaderCatchInsectUIModule.Instance.getMapRes()) as Class)() as MovieClip;
         var _loc4_:Sprite = _loc6_.getChildByName("articleLayer") as Sprite;
         var _loc2_:Sprite = _loc6_.getChildByName("NPCMouse") as Sprite;
         var _loc8_:Sprite = _loc6_.getChildByName("mesh") as Sprite;
         var _loc5_:Sprite = _loc6_.getChildByName("bg") as Sprite;
         var _loc7_:Sprite = _loc6_.getChildByName("bgSize") as Sprite;
         var _loc3_:Sprite = _loc6_.getChildByName("decoration") as Sprite;
         if(_loc7_)
         {
            MAP_SIZEII[0] = _loc7_.width;
            MAP_SIZEII[1] = _loc7_.height;
         }
         else
         {
            MAP_SIZEII[0] = _loc5_.width;
            MAP_SIZEII[1] = _loc5_.height;
         }
         _sceneScene.setHitTester(new PathMapHitTester(_loc8_));
         if(!_sceneMap)
         {
            _sceneMap = new CatchInsectScneneMap(_model,_sceneScene,_model.getPlayers(),_model.getObjects(),_loc5_,_loc8_,_loc4_,_loc2_,_loc3_);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(param1)
         {
            _sceneMap.sceneMapVO.defaultPos = param1;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var _loc1_:SceneMapVO = new SceneMapVO();
         _loc1_.mapName = LanguageMgr.GetTranslation("church.churchScene.WeddingMainScene");
         _loc1_.mapW = MAP_SIZEII[0];
         _loc1_.mapH = MAP_SIZEII[1];
         _loc1_.defaultPos = ComponentFactory.Instance.creatCustomObject("catchInsect.room.sceneMapVOPosII");
         return _loc1_;
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(param1,param2);
         }
      }
      
      public function updatePlayerStauts(param1:int, param2:int, param3:Point = null) : void
      {
         if(_sceneMap)
         {
            _sceneMap.updatePlayersStauts(param1,param2,param3);
         }
      }
      
      public function updateSelfStatus(param1:int) : void
      {
         _sceneMap.updateSelfStatus(param1);
      }
      
      private function _leaveRoom(param1:Event) : void
      {
         StateManager.setState("main");
         _contoller.dispose();
      }
      
      private function clearMap() : void
      {
         if(_sceneMap)
         {
            if(_sceneMap.parent)
            {
               _sceneMap.parent.removeChild(_sceneMap);
            }
            _sceneMap.dispose();
         }
         _sceneMap = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearMap();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _roomMenuView = null;
         _sceneScene = null;
         _sceneMap = null;
         _chatFrame = null;
         _sceneInfoViewBg = null;
         _scoreTxt = null;
         _ballCountTxt = null;
         _netCountTxt = null;
         _buyBallBtn = null;
         _buyNetBtn = null;
         _useCakeBtn = null;
         _useWhistleBtn = null;
         _helpBtn = null;
         ObjectUtils.disposeObject(_useCakeTxt);
         _useCakeTxt = null;
         ObjectUtils.disposeObject(_useWhistleTxt);
         _useWhistleTxt = null;
      }
   }
}
