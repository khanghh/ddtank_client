package ddt.view.rescue
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.ImgNumConverter;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rescue.data.RescueRoomInfo;
   
   public class RescueRoomItemView extends Sprite implements Disposeable
   {
       
      
      private var _openSp:Sprite;
      
      private var _closeSp:Sprite;
      
      private var _openBg:Bitmap;
      
      private var _closeBg:Bitmap;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _sceneImg:Bitmap;
      
      private var _scoreTxt:Sprite;
      
      private var _arrowTxt:Sprite;
      
      private var _arrowTxt2:Sprite;
      
      private var _bloodBagTxt:Sprite;
      
      private var _sceneId:int = -1;
      
      public function RescueRoomItemView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _openSp = new Sprite();
         addChild(_openSp);
         _closeSp = new Sprite();
         addChild(_closeSp);
         _closeSp.visible = false;
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("rescue.room.closeBtn");
         _openSp.addChild(_closeBtn);
         _openBg = ComponentFactory.Instance.creat("rescue.roomInfo.openBg");
         _openSp.addChild(_openBg);
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("rescue.room.openBtn");
         _closeSp.addChild(_openBtn);
         _closeBg = ComponentFactory.Instance.creat("rescue.roomInfo.closeBg");
         _closeSp.addChild(_closeBg);
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         _scoreTxt = ImgNumConverter.instance.convertToImg(0,"rescue.room.num",11);
         PositionUtils.setPos(_scoreTxt,"rescue.room.scoreTxtPos");
         _openSp.addChild(_scoreTxt);
         ObjectUtils.disposeObject(_arrowTxt);
         _arrowTxt = null;
         _arrowTxt = ImgNumConverter.instance.convertToImg(0,"rescue.room.num",11);
         PositionUtils.setPos(_arrowTxt,"rescue.room.arrowTxtPos");
         _openSp.addChild(_arrowTxt);
         ObjectUtils.disposeObject(_arrowTxt2);
         _arrowTxt2 = null;
         _arrowTxt2 = ImgNumConverter.instance.convertToImg(0,"rescue.room.num",11);
         PositionUtils.setPos(_arrowTxt2,"rescue.room.arrowTxt2Pos");
         _openSp.addChild(_arrowTxt2);
         ObjectUtils.disposeObject(_bloodBagTxt);
         _bloodBagTxt = null;
         _bloodBagTxt = ImgNumConverter.instance.convertToImg(0,"rescue.room.num",11);
         PositionUtils.setPos(_bloodBagTxt,"rescue.room.bloodBagTxtPos");
         _openSp.addChild(_bloodBagTxt);
      }
      
      private function initEvents() : void
      {
         _openBtn.addEventListener("click",__openBtnClick);
         _closeBtn.addEventListener("click",__closeBtnClick);
      }
      
      protected function __closeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _openSp.visible = false;
         _closeSp.visible = true;
      }
      
      protected function __openBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _openSp.visible = true;
         _closeSp.visible = false;
      }
      
      public function update(info:RescueRoomInfo) : void
      {
         if(info.sceneId != _sceneId)
         {
            ObjectUtils.disposeObject(_sceneImg);
            _sceneImg = null;
            _sceneImg = ComponentFactory.Instance.creat("rescue.scene" + info.sceneId);
            PositionUtils.setPos(_sceneImg,"rescue.room.sceneImgPos");
            _openSp.addChild(_sceneImg);
            _sceneId = info.sceneId;
         }
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         _scoreTxt = ImgNumConverter.instance.convertToImg(info.score,"rescue.room.num",11);
         PositionUtils.setPos(_scoreTxt,"rescue.room.scoreTxtPos");
         _openSp.addChild(_scoreTxt);
         ObjectUtils.disposeObject(_arrowTxt);
         _arrowTxt = null;
         _arrowTxt = ImgNumConverter.instance.convertToImg(info.defaultArrow,"rescue.room.num",11);
         PositionUtils.setPos(_arrowTxt,"rescue.room.arrowTxtPos");
         _openSp.addChild(_arrowTxt);
         ObjectUtils.disposeObject(_arrowTxt2);
         _arrowTxt2 = null;
         _arrowTxt2 = ImgNumConverter.instance.convertToImg(info.arrow,"rescue.room.num",11);
         PositionUtils.setPos(_arrowTxt2,"rescue.room.arrowTxt2Pos");
         _openSp.addChild(_arrowTxt2);
         ObjectUtils.disposeObject(_bloodBagTxt);
         _bloodBagTxt = null;
         _bloodBagTxt = ImgNumConverter.instance.convertToImg(info.bloodBag,"rescue.room.num",11);
         PositionUtils.setPos(_bloodBagTxt,"rescue.room.bloodBagTxtPos");
         _openSp.addChild(_bloodBagTxt);
      }
      
      private function removeEvents() : void
      {
         _openBtn.removeEventListener("click",__openBtnClick);
         _closeBtn.removeEventListener("click",__closeBtnClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _openSp = null;
         _closeSp = null;
         _openBg = null;
         _closeBg = null;
         _openBtn = null;
         _closeBtn = null;
         _sceneImg = null;
         _scoreTxt = null;
         _arrowTxt = null;
         _arrowTxt2 = null;
         _bloodBagTxt = null;
      }
   }
}
