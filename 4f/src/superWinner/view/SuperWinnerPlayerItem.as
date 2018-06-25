package superWinner.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.utils.PositionUtils;   import ddt.view.common.LevelIcon;   import ddt.view.common.SexIcon;   import flash.display.DisplayObject;   import flash.display.Sprite;   import vip.VipController;      public class SuperWinnerPlayerItem extends Sprite implements Disposeable, IListCell   {                   private var _info:PlayerInfo;            private var _levelIcon:LevelIcon;            private var _sexIcon:SexIcon;            private var _name:FilterFrameText;            private var _vipName:GradientText;            public function SuperWinnerPlayerItem() { super(); }
            private function init() : void { }
            public function dispose() : void { }
            public function get sexIcon() : SexIcon { return null; }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}