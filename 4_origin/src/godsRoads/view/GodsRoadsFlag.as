package godsRoads.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import godsRoads.manager.GodsRoadsManager;
   
   public class GodsRoadsFlag extends Component
   {
       
      
      private var _lv:int = 1;
      
      private var _alertTxt:FilterFrameText;
      
      private var _btn:BaseButton;
      
      private var _numBitmapArray:Array;
      
      private var _pointsNum:Sprite;
      
      private var _offX:int = 6;
      
      private var _perBmp:Bitmap;
      
      private var progressTxt:Bitmap;
      
      private var isOpen:Boolean = false;
      
      private var _progressNum:int;
      
      public function GodsRoadsFlag(param1:int)
      {
         _numBitmapArray = [];
         _lv = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creat("godsRoads.ddLevelBtn" + _lv);
         addChild(_btn);
         if(_lv > 1)
         {
            _alertTxt = ComponentFactory.Instance.creat("godsRoads.conditionsTxt");
            _alertTxt.text = LanguageMgr.GetTranslation("ddt.godsRoads.openConditions",LanguageMgr.GetTranslation("ddt.godsRoads.lv" + _lv));
            addChild(_alertTxt);
         }
         _pointsNum = new Sprite();
         PositionUtils.setPos(_pointsNum,"godsRoads.numPos");
         addChild(_pointsNum);
         progressTxt = ComponentFactory.Instance.creat("asset.godsRoads.programeTxt");
         progressTxt.visible = false;
         addChild(progressTxt);
         _btn.addEventListener("click",__changeSteps);
      }
      
      public function set enable(param1:Boolean) : void
      {
         isOpen = param1;
         if(param1 == true)
         {
            _btn.filterString = "null,lightFilter,null,grayFilter";
            if(_alertTxt)
            {
               _alertTxt.visible = false;
            }
         }
         else
         {
            if(_lv == GodsRoadsManager.instance._model.godsRoadsData.currentLevel + 1)
            {
               _alertTxt.textFormatStyle = "godsRoads.TextFormat";
            }
            _btn.filterString = "grayFilter,grayFilter,grayFilter,grayFilter";
            if(_alertTxt)
            {
               _alertTxt.visible = true;
            }
         }
         _btn.setFrame(1);
      }
      
      public function get isOpened() : Boolean
      {
         return isOpen;
      }
      
      private function getFA(param1:String) : Array
      {
         return ComponentFactory.Instance.creatFrameFilters(param1);
      }
      
      private function __changeSteps(param1:MouseEvent) : void
      {
         GodsRoadsManager.instance.changeSteps(_lv);
      }
      
      public function get enable() : Boolean
      {
         return isOpen;
      }
      
      public function set progressNum(param1:int) : void
      {
         _progressNum = param1;
         setCountDownNumber(_progressNum);
         showProgress = true;
      }
      
      public function get progressNum() : int
      {
         return _progressNum;
      }
      
      public function set showProgress(param1:Boolean) : void
      {
         progressTxt.visible = param1;
      }
      
      private function setCountDownNumber(param1:int) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc4_:String = String(param1);
         var _loc3_:String = "";
         var _loc2_:int = 0;
         deleteBitmapArray();
         _numBitmapArray = [];
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc3_ = _loc4_.charAt(_loc6_);
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.godsRoads.num" + _loc3_);
            _loc5_.x = _loc5_.bitmapData.width * _loc6_ - _loc6_ * _offX;
            _loc2_ = _loc5_.x + _loc5_.bitmapData.width;
            _pointsNum.addChild(_loc5_);
            _numBitmapArray.push(_loc5_);
            _loc6_++;
         }
         _perBmp = ComponentFactory.Instance.creatBitmap("asset.godsRoads.num%");
         _perBmp.x = _loc2_ - _offX;
         _pointsNum.addChild(_perBmp);
         _numBitmapArray.push(_perBmp);
      }
      
      private function deleteBitmapArray() : void
      {
         var _loc1_:int = 0;
         if(_numBitmapArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _numBitmapArray.length)
            {
               _numBitmapArray[_loc1_].bitmapData.dispose();
               _numBitmapArray[_loc1_] = null;
               _loc1_++;
            }
            _numBitmapArray.length = 0;
            _numBitmapArray = null;
         }
      }
   }
}
