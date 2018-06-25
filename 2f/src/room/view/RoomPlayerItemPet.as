package room.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.display.BitmapLoaderProxy;   import ddt.manager.PathManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.Dictionary;   import pet.data.PetInfo;   import petsBag.PetsBagManager;      public class RoomPlayerItemPet extends Sprite implements Disposeable   {                   private var _petLevel:FilterFrameText;            private var _petInfo:PetInfo;            private var _headPetWidth:Number;            private var _headPetHight:Number;            private var _excursion:Number = 3;            private var _icons:Dictionary;            public function RoomPlayerItemPet(w:Number = 0, h:Number = 0) { super(); }
            private function createPetIcon() : void { }
            public function updateView(value:PetInfo) : void { }
            private function iconvisible() : void { }
            private function __iconLoadingFinish(e:Event) : void { }
            public function dispose() : void { }
   }}