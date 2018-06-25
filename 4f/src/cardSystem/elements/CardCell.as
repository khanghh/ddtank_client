package cardSystem.elements{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import cardSystem.CardControl;   import cardSystem.CardManager;   import cardSystem.data.CardInfo;   import cardSystem.data.GrooveInfo;   import cardSystem.view.CardInputFrame;   import com.greensock.TweenMax;   import com.pickgliss.effect.IEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.CellEvent;   import ddt.manager.DragManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CardCell extends BaseCell   {                   private var _open:Boolean;            private var isVible:Boolean = true;            private var _cardInfo:CardInfo;            private var _playerInfo:PlayerInfo;            private var _place:int;            private var _cardID:int;            protected var _starContainer:Sprite;            protected var _levelBG:Bitmap;            protected var _level:FilterFrameText;            private var _starVisible:Boolean = true;            private var _cardName:FilterFrameText;            private var _shine:IEffect;            protected var _isShine:Boolean;            private var _canShine:Boolean;            protected var _updateBtn:TextButton;            protected var _resetGradeBtn:TextButton;            protected var _mainWhiteGold:Bitmap;            protected var _mainGold:ScaleFrameImage;            protected var _mainsilver:ScaleFrameImage;            protected var _maincopper:ScaleFrameImage;            protected var _deputyWhiteGold:Bitmap;            protected var _deputyGold:ScaleFrameImage;            protected var _deputysilver:ScaleFrameImage;            protected var _deputycopper:ScaleFrameImage;            private var _tweenMax:TweenMax;            public function CardCell(bg:DisplayObject, place:int = -1, $info:CardInfo = null, showLoading:Boolean = false, showTip:Boolean = true) { super(null,null); }
            public function set canShine(value:Boolean) : void { }
            public function get canShine() : Boolean { return false; }
            public function get playerInfo() : PlayerInfo { return null; }
            public function set playerInfo(value:PlayerInfo) : void { }
            public function showCardName(name:String) : void { }
            public function set cardID(value:int) : void { }
            public function get cardID() : int { return 0; }
            override protected function createChildren() : void { }
            public function shine() : void { }
            public function stopShine() : void { }
            protected function createStar() : void { }
            private function _UpdateHandler(event:MouseEvent) : void { }
            protected function __propReset(event:MouseEvent) : void { }
            public function setStarPos(posX:int, posY:int) : void { }
            public function set cardInfo(value:CardInfo) : void { }
            public function get cardInfo() : CardInfo { return null; }
            public function set updatebtnVible(value:Boolean) : void { }
            public function get updatebtnVible() : Boolean { return false; }
            protected function setStar() : void { }
            public function set starVisible(value:Boolean) : void { }
            public function set Visibles(value:Boolean) : void { }
            public function set open(value:Boolean) : void { }
            public function get open() : Boolean { return false; }
            public function set place(value:int) : void { }
            public function get place() : int { return 0; }
            override public function dragStart() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function dragStop(effect:DragEffect) : void { }
            override public function dispose() : void { }
            override protected function updateSize(sp:Sprite) : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            public function setBtnVisible(value:Boolean) : Boolean { return false; }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            override protected function createDragImg() : DisplayObject { return null; }
   }}