package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import vip.VipController;
   
   public class ConsortiaListItemView extends Sprite implements IListCell, Disposeable
   {
       
      
      private var _friendBG:ScaleFrameImage;
      
      private var _isSelected:Boolean;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _nameText:FilterFrameText;
      
      private var _info;
      
      private var _privateChatBtn:SimpleBitmapButton;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _vipName:GradientText;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _titleText:FilterFrameText;
      
      private var _triangle:ScaleFrameImage;
      
      public function ConsortiaListItemView(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __privateChatBtnClick(param1:MouseEvent) : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      private function __itemOver(param1:MouseEvent) : void{}
      
      private function __itemOut(param1:MouseEvent) : void{}
      
      private function updateTitle() : void{}
      
      private function update() : void{}
      
      private function creatAttestBtn() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function updateItemState() : void{}
      
      private function setItemSelectedState(param1:Boolean) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
