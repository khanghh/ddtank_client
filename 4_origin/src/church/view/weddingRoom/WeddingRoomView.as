package church.view.weddingRoom
{
   import church.ChurchControl;
   import church.ChurchManager;
   import church.controller.ChurchRoomController;
   import church.model.ChurchRoomModel;
   import church.view.churchScene.MoonSceneMap;
   import church.view.churchScene.SceneMap;
   import church.view.churchScene.WeddingLuxurySceneMap;
   import church.view.churchScene.WeddingSceneMap;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class WeddingRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZE:Array = [1208,835];
      
      public static const MAP_SIZEII:Array = [2011,1361];
       
      
      private var _controller:ChurchRoomController;
      
      private var _model:ChurchRoomModel;
      
      private var _sceneScene:SceneScene;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _sceneMap:SceneMap;
      
      private var _chatFrame:Sprite;
      
      private var _weddingRoomMenuView:WeddingRoomMenuView;
      
      private var _weddingRoomToolView:WeddingRoomToolView;
      
      private var _weddingRoomMask:WeddingRoomMask;
      
      public function WeddingRoomView(controller:ChurchRoomController, model:ChurchRoomModel)
      {
         super();
         _controller = controller;
         _model = model;
         initialize();
      }
      
      protected function initialize() : void
      {
         _sceneScene = new SceneScene();
         ChatManager.Instance.state = 4;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         _weddingRoomMenuView = new WeddingRoomMenuView(_model);
         addChild(_weddingRoomMenuView);
         _weddingRoomToolView = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.WeddingRoomToolView");
         _weddingRoomToolView.controller = _controller;
         _weddingRoomToolView.churchRoomModel = _model;
         addChild(_weddingRoomToolView);
         setMap();
      }
      
      public function setMap(localPos:Point = null) : void
      {
         clearMap();
         var mapRes:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(getMapRes()) as Class)() as MovieClip;
         var entity:Sprite = mapRes.getChildByName("entity") as Sprite;
         var sky:Sprite = mapRes.getChildByName("sky") as Sprite;
         var mesh:Sprite = mapRes.getChildByName("mesh") as Sprite;
         var bg:Sprite = mapRes.getChildByName("bg") as Sprite;
         _sceneScene.setHitTester(new PathMapHitTester(mesh));
         if(!_sceneMap)
         {
            switch(int(ChurchManager.instance.currentScene))
            {
               case 0:
                  _sceneMap = new MoonSceneMap(_model,_sceneScene,_model.getPlayers(),bg,mesh,entity,sky);
                  break;
               case 1:
               case 2:
                  _sceneMap = new WeddingSceneMap(_model,_sceneScene,_model.getPlayers(),bg,mesh,entity,sky);
                  break;
               case 3:
                  _sceneMap = new WeddingLuxurySceneMap(_model,_sceneScene,_model.getPlayers(),bg,mesh,entity,sky);
            }
            _sceneMap && addChildAt(_sceneMap,0);
         }
         _weddingRoomMenuView.resetView();
         _weddingRoomToolView.resetView();
         if(!ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            if(_weddingRoomToolView)
            {
               _weddingRoomToolView.inventBtnEnabled = ChurchManager.instance.currentRoom.canInvite;
            }
         }
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(localPos)
         {
            _sceneMap.sceneMapVO.defaultPos = localPos;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(id,p);
         }
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var sceneMapVO:SceneMapVO = new SceneMapVO();
         if(ChurchManager.instance.currentScene == 0)
         {
            sceneMapVO.mapName = LanguageMgr.GetTranslation("church.churchScene.MoonLightScene");
            sceneMapVO.mapW = MAP_SIZE[0];
            sceneMapVO.mapH = MAP_SIZE[1];
            sceneMapVO.defaultPos = ComponentFactory.Instance.creatCustomObject("church.WeddingRoomView.sceneMapVOPos");
         }
         else
         {
            sceneMapVO.mapName = LanguageMgr.GetTranslation("church.churchScene.WeddingMainScene");
            sceneMapVO.mapW = MAP_SIZEII[0];
            sceneMapVO.mapH = MAP_SIZEII[1];
            sceneMapVO.defaultPos = ComponentFactory.Instance.creatCustomObject("church.WeddingRoomView.sceneMapVOPosII");
         }
         return sceneMapVO;
      }
      
      public function useFire(playerID:int, fireTemplateID:int) : void
      {
         _sceneMap.useFire(playerID,fireTemplateID);
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
      
      public function getMapRes() : String
      {
         switch(int(ChurchManager.instance.currentScene))
         {
            case 0:
               return "tank.church.Map02";
            case 1:
            case 2:
               return "tank.church.Map01";
            case 3:
               return "tank.church.Map00";
         }
      }
      
      public function playerWeddingMovie() : void
      {
         this.swapChildren(_weddingRoomMask,_weddingRoomMenuView);
         addChild(_chatFrame);
         (_sceneMap as WeddingSceneMap).playWeddingMovie();
      }
      
      public function switchWeddingView() : void
      {
         if(ChurchManager.instance.currentRoom.status == "wedding_ing")
         {
            SoundManager.instance.stopMusic();
            readyStartWedding();
         }
         else
         {
            _weddingRoomMenuView.revertConfig();
            _weddingRoomMask.showMaskMovie();
            _weddingRoomMask.addEventListener("switch complete",__stopWeddingMovie);
         }
         _weddingRoomMenuView.resetView();
      }
      
      private function __stopWeddingMovie(event:Event) : void
      {
         SoundManager.instance.playMusic("3002");
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneView.stopWeddingMovie"));
         _weddingRoomToolView._toolSendCashBtn.enable = false;
         if(!ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            if(_weddingRoomToolView)
            {
               _weddingRoomToolView.inventBtnEnabled = ChurchManager.instance.currentRoom.canInvite;
            }
         }
         ChurchControl.instance.closeRefundView();
         if(_sceneMap is WeddingSceneMap)
         {
            (_sceneMap as WeddingSceneMap).stopWeddingMovie();
         }
         _weddingRoomMask.removeEventListener("switch complete",__stopWeddingMovie);
         _weddingRoomMask.dispose();
      }
      
      private function readyStartWedding() : void
      {
         _weddingRoomToolView._toolSendCashBtn.enable = true;
         _weddingRoomMask = new WeddingRoomMask(_controller);
         _weddingRoomMask.addEventListener("switch complete",__playWeddingMovie);
         addChild(_weddingRoomMask);
         if(_weddingRoomToolView && _weddingRoomToolView.parent)
         {
            _weddingRoomToolView.parent.removeChild(_weddingRoomToolView);
            addChild(_weddingRoomToolView);
         }
      }
      
      private function __playWeddingMovie(event:Event) : void
      {
         playerWeddingMovie();
         _weddingRoomMenuView.backupConfig();
         _weddingRoomMask.removeEventListener("switch complete",__playWeddingMovie);
      }
      
      public function setSaulte(id:int) : void
      {
         _sceneMap.setSalute(id);
      }
      
      public function show() : void
      {
         _controller.addChild(this);
      }
      
      public function dispose() : void
      {
         if(_sceneScene)
         {
            _sceneScene.dispose();
         }
         _sceneScene = null;
         _sceneMapVO = null;
         if(_sceneMap)
         {
            if(_sceneMap.parent)
            {
               _sceneMap.parent.removeChild(_sceneMap);
            }
            _sceneMap.dispose();
         }
         _sceneMap = null;
         if(_chatFrame.parent)
         {
            _chatFrame.parent.removeChild(_chatFrame);
         }
         _chatFrame = null;
         if(_weddingRoomMenuView)
         {
            if(_weddingRoomMenuView.parent)
            {
               _weddingRoomMenuView.parent.removeChild(_weddingRoomMenuView);
            }
            _weddingRoomMenuView.dispose();
         }
         _weddingRoomMenuView = null;
         if(_weddingRoomToolView)
         {
            if(_weddingRoomToolView.parent)
            {
               _weddingRoomToolView.parent.removeChild(_weddingRoomToolView);
            }
            _weddingRoomToolView.dispose();
         }
         _weddingRoomToolView = null;
         if(_weddingRoomMask)
         {
            _weddingRoomMask.removeEventListener("switch complete",__stopWeddingMovie);
            if(_weddingRoomMask.parent)
            {
               _weddingRoomMask.parent.removeChild(_weddingRoomMask);
            }
            _weddingRoomMask.dispose();
         }
         _weddingRoomMask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
