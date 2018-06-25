package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.PlayerPortraitView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   
   public class GirlHeadSelectView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _headGirlPhoto:PlayerPortraitView;
      
      private var _headGameHead:PlayerPortraitView;
      
      private var _headGirlPhoto2:PlayerPortraitView;
      
      private var _headNewHead:Bitmap;
      
      private var _selectCurHead:SelectedCheckButton;
      
      private var _selectNewHead:SelectedCheckButton;
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var _confirmUsingCurHead:SimpleBitmapButton;
      
      private var _confirmUsingNewHead:SimpleBitmapButton;
      
      private var _curHeadUseGirlPic:Boolean;
      
      private var _onCurHeadSelectedCallBack:Function;
      
      private var _onNewHeadSelectedCallBack:Function;
      
      private var _onCloseCallBack:Function;
      
      public function GirlHeadSelectView()
      {
         super();
         _bg = ComponentFactory.Instance.creat("asset.IM.girlHead.changeBG");
         addChild(_bg);
         _headGirlPhoto = new PlayerPortraitView("left",true,false);
         _headGirlPhoto.mouseEnabled = true;
         _headGirlPhoto.buttonMode = true;
         _headGirlPhoto.useHandCursor = true;
         _headGirlPhoto.scaleX = 0.85;
         _headGirlPhoto.scaleY = 0.9;
         PositionUtils.setPos(_headGirlPhoto,"girlHead1.pos");
         _headGirlPhoto.info = PlayerManager.Instance.Self;
         _headGirlPhoto.iconFrame = 3;
         _headGirlPhoto.addEventListener("click",onCurHeadSelectHandler);
         addChild(_headGirlPhoto);
         _headGameHead = new PlayerPortraitView("left",false,false);
         _headGameHead.mouseEnabled = true;
         _headGameHead.buttonMode = true;
         _headGameHead.useHandCursor = true;
         PositionUtils.setPos(_headGameHead,"gameHead.pos");
         _headGameHead.info = PlayerManager.Instance.Self;
         _headGameHead.iconFrame = 3;
         _headGameHead.addEventListener("click",onCurHeadSelectHandler);
         addChild(_headGameHead);
         if(PlayerManager.Instance.Self.IsShow)
         {
            _curHeadUseGirlPic = true;
            Helpers.colorful(_headGirlPhoto);
            Helpers.grey(_headGameHead);
         }
         else
         {
            _curHeadUseGirlPic = false;
            Helpers.colorful(_headGameHead);
            Helpers.grey(_headGirlPhoto);
         }
         _headGirlPhoto2 = new PlayerPortraitView("left",true,false);
         _headGirlPhoto2.mouseEnabled = true;
         _headGirlPhoto2.buttonMode = true;
         _headGirlPhoto2.useHandCursor = true;
         _headGirlPhoto2.scaleX = 0.85;
         _headGirlPhoto2.scaleY = 0.9;
         PositionUtils.setPos(_headGirlPhoto2,"girlHead2.pos");
         _headGirlPhoto2.info = PlayerManager.Instance.Self;
         _headGirlPhoto2.iconFrame = 3;
         addChild(_headGirlPhoto2);
         _headNewHead = ComponentFactory.Instance.creatBitmap("asset.IM.girlHead.newHead");
         PositionUtils.setPos(_headNewHead,"girlHead.newHead.pos");
         addChild(_headNewHead);
         _confirmUsingCurHead = ComponentFactory.Instance.creat("girlCurHead.confirmBtn");
         _confirmUsingCurHead.addEventListener("click",onConfirmUsingCurHead);
         addChild(_confirmUsingCurHead);
         _confirmUsingNewHead = ComponentFactory.Instance.creat("girlNewHead.confirmBtn");
         _confirmUsingNewHead.addEventListener("click",onConfirmUsingNewHead);
         _confirmUsingNewHead.enable = false;
         addChild(_confirmUsingNewHead);
         _selectCurHead = ComponentFactory.Instance.creat("girlCurHeadSelectBtn");
         _selectCurHead.addEventListener("click",onSelectClick);
         addChild(_selectCurHead);
         _selectNewHead = ComponentFactory.Instance.creat("girlNewHeadSelectBtn");
         _selectNewHead.addEventListener("click",onSelectClick);
         addChild(_selectNewHead);
         _selectGroup = new SelectedButtonGroup();
         _selectGroup.addSelectItem(_selectCurHead);
         _selectGroup.addSelectItem(_selectNewHead);
         _selectGroup.selectIndex = 0;
         _selectGroup.addEventListener("change",onSelectChange);
         _closeBtn = ComponentFactory.Instance.creat("IMView.closeGirlHeadPicBtn");
         addChild(_closeBtn);
         _closeBtn.addEventListener("click",onCloseBtnClick);
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         this.addEventListener("removedFromStage",onRFS);
      }
      
      protected function onConfirmUsingCurHead(e:MouseEvent) : void
      {
         _onCurHeadSelectedCallBack && _onCurHeadSelectedCallBack(_curHeadUseGirlPic);
         ObjectUtils.disposeObject(this);
      }
      
      protected function onConfirmUsingNewHead(e:MouseEvent) : void
      {
         _onNewHeadSelectedCallBack && _onNewHeadSelectedCallBack();
         ObjectUtils.disposeObject(this);
      }
      
      protected function onSelectChange(e:Event) : void
      {
         switch(int(_selectGroup.selectIndex))
         {
            case 0:
               _confirmUsingCurHead.enable = true;
               _confirmUsingNewHead.enable = false;
               break;
            case 1:
               _confirmUsingCurHead.enable = false;
               _confirmUsingNewHead.enable = true;
         }
      }
      
      protected function onSelectClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function onRFS(e:Event) : void
      {
         this.removeEventListener("removedFromStage",onRFS);
         _onCloseCallBack && _onCloseCallBack();
         _onCloseCallBack = null;
      }
      
      protected function onKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == 27)
         {
            KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
            ObjectUtils.disposeObject(this);
         }
      }
      
      protected function onCurHeadSelectHandler(e:MouseEvent) : void
      {
         var _loc2_:* = e.target;
         if(_headGirlPhoto !== _loc2_)
         {
            if(_headGameHead === _loc2_)
            {
               _curHeadUseGirlPic = false;
               Helpers.colorful(_headGameHead);
               Helpers.grey(_headGirlPhoto);
            }
         }
         else
         {
            _curHeadUseGirlPic = true;
            Helpers.colorful(_headGirlPhoto);
            Helpers.grey(_headGameHead);
         }
      }
      
      public function set onUseNewPic(value:Function) : void
      {
         _onNewHeadSelectedCallBack = value;
      }
      
      public function set onCurHeadSelected(value:Function) : void
      {
         _onCurHeadSelectedCallBack = value;
      }
      
      public function set onClose(value:Function) : void
      {
         _onCloseCallBack = value;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_headGameHead);
         _headGameHead = null;
         ObjectUtils.disposeObject(_headGirlPhoto);
         _headGirlPhoto = null;
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",onCloseBtnClick);
            ObjectUtils.disposeObject(_closeBtn);
            _closeBtn = null;
         }
         _onCurHeadSelectedCallBack = null;
      }
      
      private function onCloseBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
   }
}
