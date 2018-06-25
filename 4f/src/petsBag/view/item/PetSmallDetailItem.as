package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import pet.data.PetInfo;      public class PetSmallDetailItem extends PetSmallItem   {                   private var _starBar:StarBar;            private var _gradeTextF:FilterFrameText;            private var _nameTextF:FilterFrameText;            private var _starNum:int;            public function PetSmallDetailItem(info:PetInfo = null) { super(null); }
            override protected function initView() : void { }
            override protected function initEvent() : void { }
            override protected function removeEvent() : void { }
            public function setStarNum(num:int, assetResource:String = "assets.petsBag.star") : void { }
            public function getStarNum() : int { return 0; }
            public function setGradeTxt(grade:String) : void { }
            public function setNameTxt($name:String) : void { }
   }}