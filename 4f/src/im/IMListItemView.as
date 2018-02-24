package im
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import ddt.manager.ChatManager;
   import ddt.manager.DragManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import vip.VipController;
   
   public class IMListItemView extends Sprite implements IListCell, Disposeable, IDragable, IAcceptDrag
   {
      
      public static var MAX_CHAR:int = 7;
      
      public static const FRIEND_ITEM:int = 0;
      
      public static const TITLE_ITEM:int = 1;
       
      
      private var _titleBG:ScaleFrameImage;
      
      private var _friendBG:ScaleFrameImage;
      
      private var _triangle:ScaleFrameImage;
      
      private var _state:ScaleFrameImage;
      
      private var _isSelected:Boolean;
      
      private var _type:int;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexMoive:MovieClip;
      
      private var _sexIcon:SexIcon;
      
      private var _masterIcon:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _titleText:FilterFrameText;
      
      private var _numText:FilterFrameText;
      
      private var _info:FriendListPlayer;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _markBtn:SimpleBitmapButton;
      
      private var _snsInviteBtn:SimpleBitmapButton;
      
      private var _deleteBtn:SimpleBitmapButton;
      
      private var _callBackBtn:SimpleBitmapButton;
      
      private var _callBackedBitmap:Bitmap;
      
      private var _vipName:GradientText;
      
      private var _colorMatrixSp:Sprite;
      
      private var _CMFIcon:Image;
      
      private var _iconBitmap:Bitmap;
      
      private var _stateoldx:int;
      
      private var _city:ScaleFrameImage;
      
      private var _customInput:TextInput;
      
      private var _markInput:TextInput;
      
      private var _hasDouble:Boolean = false;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _markBtnClicked:Boolean = false;
      
      public function IMListItemView(){super();}
      
      private function init() : void{}
      
      private function setCallBackBtnEnable() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function __alertMessage(param1:Event) : void{}
      
      protected function __hasNewMessage(param1:Event) : void{}
      
      protected function __doubleClickhandler(param1:InteractiveEvent) : void{}
      
      protected function __customInputHandler(param1:MouseEvent) : void{}
      
      private function _callBackBtnClick(param1:MouseEvent) : void{}
      
      private function __deleteBtnClick(param1:MouseEvent) : void{}
      
      private function __privateChatBtnClick(param1:MouseEvent) : void{}
      
      private function __markBtnClick(param1:MouseEvent) : void{}
      
      protected function __snsInviteBtnClick(param1:MouseEvent) : void{}
      
      private function __itemClick(param1:InteractiveEvent) : void{}
      
      public function onMarkClick(param1:CEvent) : void{}
      
      private function createCustomInput() : void{}
      
      private function createMarkInput() : void{}
      
      private function __itemOver(param1:MouseEvent) : void{}
      
      private function __itemOut(param1:MouseEvent) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      private function update() : void{}
      
      private function updateTilte() : void{}
      
      private function clearCustomInput() : void{}
      
      private function clearMarkInput() : void{}
      
      protected function __fucksOutHandler(param1:FocusEvent) : void{}
      
      protected function __markOutHandler(param1:FocusEvent) : void{}
      
      protected function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      private function updateBtn() : void{}
      
      private function updateItem() : void{}
      
      private function creatAttestBtn() : void{}
      
      private function updateMasetrIcon() : void{}
      
      private function updateItemState() : void{}
      
      private function setItemSelectedState(param1:Boolean) : void{}
      
      public function getSource() : IDragable{return null;}
      
      public function dragStop(param1:DragEffect) : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function dragStart() : void{}
      
      private function createImg() : DisplayObject{return null;}
      
      public function dispose() : void{}
      
      public function get callBackBtn() : SimpleBitmapButton{return null;}
      
      public function set callBackBtn(param1:SimpleBitmapButton) : void{}
      
      public function get info() : FriendListPlayer{return null;}
      
      public function set info(param1:FriendListPlayer) : void{}
   }
}
