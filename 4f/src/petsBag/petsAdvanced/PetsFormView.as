package petsBag.petsAdvanced{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import hall.event.NewHallEvent;   import petsBag.data.PetsFormData;   import petsBag.event.PetItemEvent;   import road7th.comm.PackageIn;      public class PetsFormView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _shiner:Bitmap;            private var _lifeGuard:FilterFrameText;            private var _absorbHurt:FilterFrameText;            private var _prePageBtn:SimpleBitmapButton;            private var _nextPageBtn:SimpleBitmapButton;            private var _currentPageInput:Scale9CornerImage;            private var _currentPage:FilterFrameText;            private var _page:int = 1;            private var _countPage:int = 1;            private var _petsVec:Vector.<PetsFormPetsItem>;            public function PetsFormView() { super(); }
            private function sendPkg() : void { }
            private function initData() : void { }
            private function initView() : void { }
            private function creatPetsView() : void { }
            protected function __onClickPetsItem(event:PetItemEvent) : void { }
            private function setShinerPos(id:int) : void { }
            private function setItemInfo() : void { }
            private function initEvent() : void { }
            protected function __onPrePageClick(event:MouseEvent) : void { }
            protected function __onNextPageClick(event:MouseEvent) : void { }
            private function setPageInfo() : void { }
            protected function __onGetPetsFormInfo(event:PkgEvent) : void { }
            protected function __onPetsWake(event:PkgEvent) : void { }
            protected function __onPetsFollowOrCall(event:PkgEvent) : void { }
            private function resetItemInfo(tempId:int, showBtn:int, index:int) : void { }
            private function removeEvent() : void { }
            private function deletePets() : void { }
            public function dispose() : void { }
   }}