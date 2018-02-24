package ddt.view.caddyII.celebration
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.LookTrophy;
   import ddt.view.caddyII.RightView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class CelebrationBoxView extends RightView
   {
      
      public static const SELECT_SCALE_NUMBER:Number = 0;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _gridBGI:MovieImage;
      
      private var _lookBtn:TextButton;
      
      private var _openBtn:BaseButton;
      
      private var _turnBG:ScaleFrameImage;
      
      private var _movie:MovieImage;
      
      private var _keyBtn:BaseButton;
      
      private var _boxBtn:BaseButton;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _selectCell:BaseCell;
      
      private var _keyNumberTxt:FilterFrameText;
      
      private var _boxNumberTxt:FilterFrameText;
      
      private var _lookTrophy:LookTrophy;
      
      private var _keyNumber:int;
      
      private var _boxNumber:int;
      
      private var _selectedCount:int;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _endFrame:int;
      
      private var _selectSprite:Sprite;
      
      private var _cellMC:MovieClip;
      
      public function CelebrationBoxView(){super();}
      
      override public function setType(param1:int) : void{}
      
      override public function set item(param1:ItemTemplateInfo) : void{}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function createSelectCell() : void{}
      
      private function _bagUpdate(param1:BagEvent) : void{}
      
      private function _look(param1:MouseEvent) : void{}
      
      private function __openClick(param1:MouseEvent) : void{}
      
      private function openImp() : void{}
      
      private function __selectedChanged(param1:Event) : void{}
      
      private function creatShape(param1:Number = 100, param2:Number = 25) : Shape{return null;}
      
      private function __frameHandler(param1:Event) : void{}
      
      private function creatTweenSelectMagnify() : void{}
      
      private function _moveOk() : void{}
      
      private function _toMove() : void{}
      
      public function set keyNumber(param1:int) : void{}
      
      public function get keyNumber() : int{return 0;}
      
      public function set boxNumber(param1:int) : void{}
      
      public function get boxNumber() : int{return 0;}
      
      override public function again() : void{}
      
      override public function setSelectGoodsInfo(param1:InventoryItemInfo) : void{}
      
      private function _startTurn() : void{}
      
      override public function get openBtnEnable() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
