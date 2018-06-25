package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import pet.data.PetInfo;
   
   public class PetSmallDetailItem extends PetSmallItem
   {
       
      
      private var _starBar:StarBar;
      
      private var _gradeTextF:FilterFrameText;
      
      private var _nameTextF:FilterFrameText;
      
      private var _starNum:int;
      
      public function PetSmallDetailItem(info:PetInfo = null)
      {
         super(info);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _starBar = new StarBar();
         _starBar.y = 60;
         var _loc1_:* = 0.55;
         _starBar.scaleY = _loc1_;
         _starBar.scaleX = _loc1_;
         _starBar.starNum(0);
         addChild(_starBar);
         _gradeTextF = ComponentFactory.Instance.creat("petsBag.break.icon.GradeTxt");
         _gradeTextF.text = "";
         addChild(_gradeTextF);
         _nameTextF = ComponentFactory.Instance.creat("petsBag.break.icon.PetNameTxt");
         _nameTextF.text = "";
         addChild(_nameTextF);
      }
      
      override protected function initEvent() : void
      {
      }
      
      override protected function removeEvent() : void
      {
      }
      
      public function setStarNum(num:int, assetResource:String = "assets.petsBag.star") : void
      {
         _starNum = num;
         _starBar.starNum(num,assetResource);
      }
      
      public function getStarNum() : int
      {
         return _starNum;
      }
      
      public function setGradeTxt(grade:String) : void
      {
         if(grade == "" || grade == "0")
         {
            _gradeTextF.text = "";
            _gradeTextF.parent && removeChild(_gradeTextF);
            return;
         }
         addChild(_gradeTextF);
         _gradeTextF.text = "Lv" + grade;
      }
      
      public function setNameTxt($name:String) : void
      {
         _nameTextF.text = $name;
      }
   }
}
