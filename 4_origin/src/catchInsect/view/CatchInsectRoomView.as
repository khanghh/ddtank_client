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
      
      public function CatchInsectRoomView(controller:CatchInsectRoomController, model:CatchInsectRoomModel)
      {
         super();
         this._contoller = controller;
         this._model = model;
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
         var count1:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11958);
         var count2:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11968);
         _useCakeTxt.text = count1 + "";
         _useWhistleTxt.text = count2 + "";
         _useCakeTxt.visible = count1 < 1?false:true;
         _useWhistleTxt.visible = count2 < 1?false:true;
      }
      
      private function __updateFightMonster(event:CatchInsectRoomEvent) : void
      {
         if(_useWhistleBtn)
         {
            _useWhistleBtn.enable = !CatchInsectControl.instance.isRefreshMonster;
         }
      }
      
      protected function __useCakeBtnClick(event:MouseEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11958);
         if(info)
         {
            SocketManager.Instance.out.sendUseCard(info.BagType,info.Place,[info.TemplateID],info.PayType);
            SocketManager.Instance.out.requestCakeStatus();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("catchInsect.noCake"));
            _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _quick.itemID = 11958;
            LayerManager.Instance.addToLayer(_quick,2,true,1);
         }
      }
      
      protected function __useWhistleBtnClick(event:MouseEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11968);
         if(info)
         {
            SocketManager.Instance.out.requestInsectWhistleUse(11968);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("catchInsect.noWhistle"));
            _quick = ComponentFactory.Instance.creatComponentByStylename("catchInsect.QuickFrame");
            _quick.itemID = 11968;
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(_quick,2,true,1);
         }
      }
      
      protected function __updateScore(event:Event) : void
      {
         var total:int = CatchInsectManager.instance.model.score;
         var avaible:int = CatchInsectManager.instance.model.avaibleScore;
         _scoreTxt.text = avaible.toString();
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
      
      protected function __updateGoods(evt:BagEvent) : void
      {
         _ballCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10615).toString();
         _netCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(10616).toString();
         updateBtnTxt();
      }
      
      protected function __buyNetBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 10616;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      protected function __buyBallBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 10615;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
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
      
      public function setMap(localPos:Point = null) : void
      {
         clearMap();
         var mapRes:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(LoaderCatchInsectUIModule.Instance.getMapRes()) as Class)() as MovieClip;
         var entity:Sprite = mapRes.getChildByName("articleLayer") as Sprite;
         var sky:Sprite = mapRes.getChildByName("NPCMouse") as Sprite;
         var mesh:Sprite = mapRes.getChildByName("mesh") as Sprite;
         var bg:Sprite = mapRes.getChildByName("bg") as Sprite;
         var bgSize:Sprite = mapRes.getChildByName("bgSize") as Sprite;
         var decoration:Sprite = mapRes.getChildByName("decoration") as Sprite;
         if(bgSize)
         {
            MAP_SIZEII[0] = bgSize.width;
            MAP_SIZEII[1] = bgSize.height;
         }
         else
         {
            MAP_SIZEII[0] = bg.width;
            MAP_SIZEII[1] = bg.height;
         }
         _sceneScene.setHitTester(new PathMapHitTester(mesh));
         if(!_sceneMap)
         {
            _sceneMap = new CatchInsectScneneMap(_model,_sceneScene,_model.getPlayers(),_model.getObjects(),bg,mesh,entity,sky,decoration);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(localPos)
         {
            _sceneMap.sceneMapVO.defaultPos = localPos;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var sceneMapVO:SceneMapVO = new SceneMapVO();
         sceneMapVO.mapName = LanguageMgr.GetTranslation("church.churchScene.WeddingMainScene");
         sceneMapVO.mapW = MAP_SIZEII[0];
         sceneMapVO.mapH = MAP_SIZEII[1];
         sceneMapVO.defaultPos = ComponentFactory.Instance.creatCustomObject("catchInsect.room.sceneMapVOPosII");
         return sceneMapVO;
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(id,p);
         }
      }
      
      public function updatePlayerStauts(id:int, status:int, point:Point = null) : void
      {
         if(_sceneMap)
         {
            _sceneMap.updatePlayersStauts(id,status,point);
         }
      }
      
      public function updateSelfStatus(value:int) : void
      {
         _sceneMap.updateSelfStatus(value);
      }
      
      private function _leaveRoom(e:Event) : void
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
