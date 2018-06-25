package consortion.view.selfConsortia{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import consortion.data.CallBackModel;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;      public class CallBackItem extends Sprite implements Disposeable   {                   private var _itemCell:BagCell;            private var _index:int;            private var _callBackModel:CallBackModel;            private var _completeFlag:Bitmap;            public function CallBackItem() { super(); }
            private function init() : void { }
            public function setData(index:int) : void { }
            private function leftCallBackCount() : int { return 0; }
            private function onClick(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}