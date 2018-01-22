package HappyRecharge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class HappyRechargeRecordView extends Sprite implements Disposeable
   {
       
      
      private var _conText:FilterFrameText;
      
      private var _type:int;
      
      public function HappyRechargeRecordView(param1:int = 10)
      {
         super();
         _type = param1;
         initText();
      }
      
      private function initText() : void
      {
         if(_type >= 10 && _type <= 12)
         {
            switch(int(_type) - 10)
            {
               case 0:
               case 1:
                  _conText = ComponentFactory.Instance.creatComponentByStylename("mainframe.record.commondTxt");
                  break;
               case 2:
                  _conText = ComponentFactory.Instance.creatComponentByStylename("mainframe.record.specialTxt");
            }
            addChild(_conText);
         }
      }
      
      public function setText(param1:String, param2:String, param3:int) : void
      {
         if(_conText)
         {
            _conText.text = LanguageMgr.GetTranslation("happyRecharge.mainFrame.record" + _type,param1,param2,param3);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_conText);
         _conText = null;
      }
   }
}
