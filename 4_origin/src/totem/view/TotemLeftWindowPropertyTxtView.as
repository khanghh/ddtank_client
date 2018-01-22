package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class TotemLeftWindowPropertyTxtView extends Sprite implements Disposeable
   {
       
      
      private var _levelTxtList:Vector.<FilterFrameText>;
      
      private var _txtArray:Array;
      
      public function TotemLeftWindowPropertyTxtView()
      {
         var _loc2_:int = 0;
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         _levelTxtList = new Vector.<FilterFrameText>();
         _loc2_ = 1;
         while(_loc2_ <= 7)
         {
            _levelTxtList.push(ComponentFactory.Instance.creatComponentByStylename("totem.totemWindow.propertyName" + _loc2_));
            _loc2_++;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("ddt.totem.sevenProperty");
         _txtArray = _loc1_.split(",");
      }
      
      public function show(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _levelTxtList[_loc2_].x = param1[_loc2_].x - 48;
            _levelTxtList[_loc2_].y = param1[_loc2_].y + 22;
            addChild(_levelTxtList[_loc2_]);
            _loc2_++;
         }
      }
      
      public function refreshLayer(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _levelTxtList[_loc2_].text = LanguageMgr.GetTranslation("ddt.totem.totemWindow.propertyLvTxt",param1,_txtArray[_loc2_]);
            _loc2_++;
         }
      }
      
      public function scaleTxt(param1:Number) : void
      {
         var _loc3_:int = 0;
         if(!_levelTxtList)
         {
            return;
         }
         var _loc2_:int = _levelTxtList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _levelTxtList[_loc3_].scaleX = param1;
            _levelTxtList[_loc3_].scaleY = param1;
            _levelTxtList[_loc3_].x = _levelTxtList[_loc3_].x - 5;
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _levelTxtList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
