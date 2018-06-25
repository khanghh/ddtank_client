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
      
      public function GodsRoadsFlag(lv:int)
      {
         _numBitmapArray = [];
         _lv = lv;
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
      
      public function set enable(val:Boolean) : void
      {
         isOpen = val;
         if(val == true)
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
      
      private function getFA(str:String) : Array
      {
         return ComponentFactory.Instance.creatFrameFilters(str);
      }
      
      private function __changeSteps(e:MouseEvent) : void
      {
         GodsRoadsManager.instance.changeSteps(_lv);
      }
      
      public function get enable() : Boolean
      {
         return isOpen;
      }
      
      public function set progressNum(val:int) : void
      {
         _progressNum = val;
         setCountDownNumber(_progressNum);
         showProgress = true;
      }
      
      public function get progressNum() : int
      {
         return _progressNum;
      }
      
      public function set showProgress(val:Boolean) : void
      {
         progressTxt.visible = val;
      }
      
      private function setCountDownNumber(points:int) : void
      {
         var bitmap:* = null;
         var i:int = 0;
         var pointsStr:String = String(points);
         var num:String = "";
         var _x:int = 0;
         deleteBitmapArray();
         _numBitmapArray = [];
         for(i = 0; i < pointsStr.length; )
         {
            num = pointsStr.charAt(i);
            bitmap = ComponentFactory.Instance.creatBitmap("asset.godsRoads.num" + num);
            bitmap.x = bitmap.bitmapData.width * i - i * _offX;
            _x = bitmap.x + bitmap.bitmapData.width;
            _pointsNum.addChild(bitmap);
            _numBitmapArray.push(bitmap);
            i++;
         }
         _perBmp = ComponentFactory.Instance.creatBitmap("asset.godsRoads.num%");
         _perBmp.x = _x - _offX;
         _pointsNum.addChild(_perBmp);
         _numBitmapArray.push(_perBmp);
      }
      
      private function deleteBitmapArray() : void
      {
         var i:int = 0;
         if(_numBitmapArray)
         {
            for(i = 0; i < _numBitmapArray.length; )
            {
               _numBitmapArray[i].bitmapData.dispose();
               _numBitmapArray[i] = null;
               i++;
            }
            _numBitmapArray.length = 0;
            _numBitmapArray = null;
         }
      }
   }
}
