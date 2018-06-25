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
         var i:int = 0;
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         _levelTxtList = new Vector.<FilterFrameText>();
         for(i = 1; i <= 7; )
         {
            _levelTxtList.push(ComponentFactory.Instance.creatComponentByStylename("totem.totemWindow.propertyName" + i));
            i++;
         }
         var tmp:String = LanguageMgr.GetTranslation("ddt.totem.sevenProperty");
         _txtArray = tmp.split(",");
      }
      
      public function show(location:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < 7; )
         {
            _levelTxtList[i].x = location[i].x - 48;
            _levelTxtList[i].y = location[i].y + 22;
            addChild(_levelTxtList[i]);
            i++;
         }
      }
      
      public function refreshLayer(level:int) : void
      {
         var i:int = 0;
         for(i = 0; i < 7; )
         {
            _levelTxtList[i].text = LanguageMgr.GetTranslation("ddt.totem.totemWindow.propertyLvTxt",level,_txtArray[i]);
            i++;
         }
      }
      
      public function scaleTxt(scale:Number) : void
      {
         var i:int = 0;
         if(!_levelTxtList)
         {
            return;
         }
         var len:int = _levelTxtList.length;
         for(i = 0; i < len; )
         {
            _levelTxtList[i].scaleX = scale;
            _levelTxtList[i].scaleY = scale;
            _levelTxtList[i].x = _levelTxtList[i].x - 5;
            i++;
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
