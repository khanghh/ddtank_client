package labyrinth.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.SimpleAlert;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;      public class CleanOutConfirmView extends SimpleAlert   {                   private var _vip6cut:Bitmap;            private var _vip9cut:Bitmap;            public function CleanOutConfirmView() { super(); }
            override public function set info(value:AlertInfo) : void { }
            override protected function onProppertiesUpdate() : void { }
            override public function dispose() : void { }
   }}