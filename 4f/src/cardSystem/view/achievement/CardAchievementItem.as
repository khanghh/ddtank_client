package cardSystem.view.achievement{   import cardSystem.CardManager;   import cardSystem.data.CardAchievementInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import newTitle.NewTitleManager;   import newTitle.model.NewTitleModel;   import road7th.DDTAssetManager;      public class CardAchievementItem extends Sprite implements Disposeable, IListCell   {                   private const propertyValue:Array = ["attack","defence","luck","damage","recovery","magicAttack","magicDefend","MaxHp"];            private var _info:CardAchievementInfo;            private var _bg:Bitmap;            private var _getBtn:SimpleBitmapButton;            private var _light:Bitmap;            private var _awardBg:Bitmap;            private var _completeIcon:Bitmap;            private var _taskTitle:FilterFrameText;            private var _taskContent:FilterFrameText;            private var _newTitleBg:Bitmap;            private var _titleText:FilterFrameText;            private var _titleImage:Bitmap;            private var _progressLabel:FilterFrameText;            private var _progressText:FilterFrameText;            private var _progress:MovieClip;            private var _propertyTextList:Vector.<CardAchievementItemProperty>;            public function CardAchievementItem() { super(); }
            private function init() : void { }
            private function initEvent() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            private function updateProgress() : void { }
            private function updateTitle() : void { }
            private function updateProperty() : void { }
            private function getCurrentProperty() : Array { return null; }
            private function __onClickGet(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}import com.pickgliss.ui.ComponentFactory;import com.pickgliss.ui.core.Disposeable;import com.pickgliss.ui.text.FilterFrameText;import com.pickgliss.utils.ObjectUtils;import ddt.manager.LanguageMgr;import flash.display.Sprite;class CardAchievementItemProperty extends Sprite implements Disposeable{          private var _propertyText:FilterFrameText;      private var _propertyValue:FilterFrameText;      function CardAchievementItemProperty() { super(); }
      public function updateProperty(type:String, value:String) : void { }
      public function dispose() : void { }
}