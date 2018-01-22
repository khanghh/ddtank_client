package hall.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.GirlHeadPicLoader;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   
   public class HallPlayerOperateView extends Sprite
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 150;
       
      
      private var _bg:Bitmap;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headSprite:Sprite;
      
      private var _nickName:FilterFrameText;
      
      private var _operateSprite:Sprite;
      
      private var _operate:FilterFrameText;
      
      private var _upDownBtn:ScaleFrameImage;
      
      private var _playerTips:HallPlayerTips;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _playerInfo:PlayerInfo;
      
      private var _girlHeadPhotoLoader:GirlHeadPicLoader;
      
      public function HallPlayerOperateView()
      {
         super();
         this.visible = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("hall.player.operate.bg");
         addChild(_bg);
         _nickName = ComponentFactory.Instance.creatComponentByStylename("hall.playerOperate.nickNameTxt");
         addChild(_nickName);
         _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
         PositionUtils.setPos(_attestBtn,"hall.playerInfo.attestPos");
         addChild(_attestBtn);
         _attestBtn.visible = false;
         _operateSprite = new Sprite();
         PositionUtils.setPos(_operateSprite,"hall.playerView.playerOperate.operateBtnPos");
         _operateSprite.buttonMode = true;
         addChild(_operateSprite);
         _operate = ComponentFactory.Instance.creatComponentByStylename("hall.playerOperate.operateTxt");
         _operate.text = LanguageMgr.GetTranslation("operate");
         _operateSprite.addChild(_operate);
         _upDownBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerOperate.upDownBtn");
         _operateSprite.addChild(_upDownBtn);
         _upDownBtn.setFrame(1);
         _playerTips = new HallPlayerTips();
         PositionUtils.setPos(_playerTips,"hall.playerView.playerOperate.tipPos");
         addChild(_playerTips);
         var _loc1_:Boolean = true;
         _playerTips.mouseEnabled = _loc1_;
         _playerTips.mouseChildren = _loc1_;
         _playerTips.visible = false;
      }
      
      public function loadHead() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         if(_headSprite)
         {
            ObjectUtils.disposeAllChildren(_headSprite);
            _headSprite = null;
         }
         if(_girlHeadPhotoLoader)
         {
            ObjectUtils.disposeObject(_girlHeadPhotoLoader);
            _girlHeadPhotoLoader = null;
         }
         if(_playerInfo.ImagePath != "" && _playerInfo.IsShow)
         {
            _girlHeadPhotoLoader = new GirlHeadPicLoader();
            _girlHeadPhotoLoader.load("http://ddthead.7road.com" + _playerInfo.ImagePath,callGirlHeadPhotoLoaded);
         }
         else
         {
            _headLoader = new SceneCharacterLoaderHead(_playerInfo);
            _headLoader.load(headLoaderCallBack);
         }
      }
      
      private function callGirlHeadPhotoLoaded(param1:DisplayObject) : void
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            _headSprite = new Sprite();
            addChild(_headSprite);
            _loc2_ = new Shape();
            _loc2_.graphics.beginFill(16777215);
            _loc2_.graphics.drawCircle(29,29,29);
            _loc2_.graphics.endFill();
            param1.mask = _loc2_;
            _headSprite.x = 7;
            _headSprite.y = -10;
            _headSprite.addChild(param1);
            _headSprite.addChild(_loc2_);
            if(param1.width > param1.height)
            {
               Helpers.scaleDisplayObject(param1,null,58);
            }
            else
            {
               Helpers.scaleDisplayObject(param1,58,null);
            }
         }
      }
      
      private function initEvent() : void
      {
         _operateSprite.addEventListener("click",__onClick);
         _playerTips.addEventListener("click",__onTipsClick);
         PlayerManager.Instance.addEventListener("newhallsetplayertippos",__onUpdateInfo);
      }
      
      protected function __onTipsClick(param1:MouseEvent) : void
      {
         _upDownBtn.setFrame(1);
      }
      
      protected function __onUpdateInfo(param1:NewHallEvent) : void
      {
         var _loc2_:PlayerVO = param1.data[0];
         if(_loc2_)
         {
            this.visible = true;
            if(!_playerInfo || _playerInfo.ID != _loc2_.playerInfo.ID)
            {
               _playerInfo = _loc2_.playerInfo;
               loadHead();
            }
            _nickName.text = _playerInfo.NickName;
            _playerTips.setInfo(_playerInfo.NickName,_playerInfo.ID);
            this.x = _loc2_.opposePos.x - 80;
            this.y = _loc2_.opposePos.y - 280;
            _attestBtn.visible = _loc2_.playerInfo.isAttest;
         }
         else
         {
            _upDownBtn.setFrame(1);
            _playerTips.visible = false;
            this.visible = false;
         }
      }
      
      protected function __onClick(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(_upDownBtn.getFrame == 1)
         {
            _upDownBtn.setFrame(2);
            _playerTips.visible = true;
            stage.addEventListener("click",__onStageClick);
         }
         else
         {
            _upDownBtn.setFrame(1);
            _playerTips.visible = false;
         }
      }
      
      protected function __onStageClick(param1:MouseEvent) : void
      {
         stage.removeEventListener("click",__onStageClick);
         _upDownBtn.setFrame(1);
         _playerTips.visible = false;
      }
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1)
         {
            _headSprite = new Sprite();
            PositionUtils.setPos(_headSprite,"hall.playerView.playerOperate.headPos");
            addChild(_headSprite);
            _loc3_ = new Bitmap();
            _loc4_ = new Rectangle(0,0,HeadWidth,HeadHeight);
            _loc5_ = new BitmapData(HeadWidth,HeadHeight,true,0);
            _loc5_.copyPixels(param1.getContent()[0] as BitmapData,_loc4_,new Point(0,0));
            _loc3_.bitmapData = _loc5_;
            param1.dispose();
            _loc3_.rotationY = 180;
            var _loc7_:* = 0.8;
            _loc3_.scaleY = _loc7_;
            _loc3_.scaleX = _loc7_;
            _loc6_ = ComponentFactory.Instance.creat("hall.player.operate.mask");
            PositionUtils.setPos(_loc6_,"hall.playerView.playerOperate.maskPos");
            _headSprite.mask = _loc6_;
            _headSprite.addChild(_loc3_);
            _headSprite.addChild(_loc6_);
         }
      }
      
      private function removeEvent() : void
      {
         _operateSprite.removeEventListener("click",__onClick);
         _playerTips.removeEventListener("click",__onTipsClick);
         PlayerManager.Instance.removeEventListener("newhallsetplayertippos",__onUpdateInfo);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_operateSprite)
         {
            ObjectUtils.disposeAllChildren(_operateSprite);
            _operateSprite = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(_girlHeadPhotoLoader)
         {
            ObjectUtils.disposeObject(_girlHeadPhotoLoader);
            _girlHeadPhotoLoader = null;
         }
      }
   }
}
