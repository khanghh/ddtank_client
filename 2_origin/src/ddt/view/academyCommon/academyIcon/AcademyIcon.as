package ddt.view.academyCommon.academyIcon
{
   import academy.AcademyManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class AcademyIcon extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _icon:ScaleFrameImage;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      public function AcademyIcon()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.academyIcon.academyIconBG");
         _icon.setFrame(1);
         addChild(_icon);
         ShowTipManager.Instance.addTip(this);
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
      }
      
      private function updateIcon() : void
      {
         if(_tipData.apprenticeshipState == 0)
         {
            this.filters = [_myColorMatrix_filter];
         }
         else
         {
            this.filters = null;
         }
         if(_tipData.Grade >= 21)
         {
            _icon.setFrame(2);
         }
         else
         {
            _icon.setFrame(1);
         }
         if(_tipData.ID == PlayerManager.Instance.Self.ID)
         {
            buttonMode = true;
            addEventListener("click",__onClick);
         }
         else
         {
            buttonMode = false;
            removeEventListener("click",__onClick);
         }
         if(_tipData.apprenticeshipState == 0 && (_tipData.Grade < 8 || AcademyManager.Instance.isOpenSpace(_tipData as PlayerInfo)))
         {
            _icon.visible = false;
         }
         else
         {
            _icon.visible = true;
         }
         if(AcademyManager.Instance.isFighting())
         {
            buttonMode = false;
         }
         else
         {
            buttonMode = true;
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(AcademyManager.Instance.isFighting())
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_tipData.apprenticeshipState == 0)
         {
            AcademyFrameManager.Instance.showAcademyPreviewFrame();
         }
         else
         {
            AcademyManager.Instance.myAcademy();
         }
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeEventListener("click",__onClick);
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         _myColorMatrix_filter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
         updateIcon();
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
