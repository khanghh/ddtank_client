package horse.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import horse.HorseAmuletManager;   import horse.HorseManager;   import horse.data.HorseAmuletVo;   import horse.data.HorseTemplateVo;   import horse.horsePicCherish.HorsePicCherishFrame;      public class HorseFrameRightTopView extends Sprite implements Disposeable   {                   private var _addPropertyValueTxtList:Vector.<FilterFrameText>;            private var _addSecondPropertyValueTxtList:Vector.<FilterFrameText>;            public function HorseFrameRightTopView() { super(); }
            private function initView() : void { }
            public function updateSelfTips() : void { }
            private function initEvent() : void { }
            private function upHorseHandler(event:Event) : void { }
            private function skillClickHandler(event:MouseEvent) : void { }
            private function picClickHandler(event:MouseEvent) : void { }
            private function __onAmuletHandler(e:MouseEvent) : void { }
            private function refreshView(event:Event = null) : void { }
            private function refreshNextView(event:Event = null) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}