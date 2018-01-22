package gemstone.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class GemstoneCurInfo extends Sprite implements Disposeable
   {
       
      
      private var _title1:Bitmap;
      
      private var _title2:Bitmap;
      
      private var _titleTxt1:FilterFrameText;
      
      private var _titleTxt2:FilterFrameText;
      
      private var _descriptTxt:FilterFrameText;
      
      private var _pdescriptTxt:FilterFrameText;
      
      private var _pZbdescriptTxt:FilterFrameText;
      
      private var _pZbZhidescriptTxt:FilterFrameText;
      
      private var _pZbdescriptTxt1:FilterFrameText;
      
      private var _pZbZhidescriptTxt1:FilterFrameText;
      
      private var _pdescriptTxt1:FilterFrameText;
      
      private var _pdescriptTxt2:FilterFrameText;
      
      private var _pdescriptTxt3:FilterFrameText;
      
      public function GemstoneCurInfo()
      {
         super();
         _title1 = ComponentFactory.Instance.creatBitmap("gemstone.tiao");
         _title1.y = 137;
         addChild(_title1);
         _title2 = ComponentFactory.Instance.creatBitmap("gemstone.tiao");
         _title2.y = 292;
         addChild(_title2);
         _titleTxt1 = ComponentFactory.Instance.creatComponentByStylename("curZhanhun");
         _titleTxt1.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.title1");
         _titleTxt1.y = 142;
         addChild(_titleTxt1);
         _titleTxt2 = ComponentFactory.Instance.creatComponentByStylename("curZhanhunzb");
         _titleTxt2.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.title2");
         _titleTxt2.y = 296;
         addChild(_titleTxt2);
         _descriptTxt = ComponentFactory.Instance.creatComponentByStylename("descriptTxt");
         _descriptTxt.width = 160;
         _descriptTxt.x = 10;
         _descriptTxt.y = 7;
         _descriptTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.descriptTxt");
         addChild(_descriptTxt);
         _pdescriptTxt1 = ComponentFactory.Instance.creatComponentByStylename("pdescriptTxt");
         _pdescriptTxt1.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt1");
         _pdescriptTxt1.x = 12;
         _pdescriptTxt1.y = 178;
         addChild(_pdescriptTxt1);
         _pdescriptTxt3 = ComponentFactory.Instance.creatComponentByStylename("pdescriptTxt");
         _pdescriptTxt3.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3");
         _pdescriptTxt3.x = 12;
         _pdescriptTxt3.y = 200;
         addChild(_pdescriptTxt3);
         _pZbdescriptTxt = ComponentFactory.Instance.creatComponentByStylename("pZbdescriptTxt");
         _pZbdescriptTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pZbdescriptTxt");
         _pZbdescriptTxt.x = 10;
         _pZbdescriptTxt.y = 330;
         addChild(_pZbdescriptTxt);
         _pZbdescriptTxt1 = ComponentFactory.Instance.creatComponentByStylename("pZbdescriptTxt");
         _pZbdescriptTxt1.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pZbdescriptTxt1");
         _pZbdescriptTxt1.x = 10;
         _pZbdescriptTxt1.y = 360;
         addChild(_pZbdescriptTxt1);
         _pZbZhidescriptTxt1 = ComponentFactory.Instance.creatComponentByStylename("pZbZhidescriptTxt");
         _pZbZhidescriptTxt1.x = 103;
         _pZbZhidescriptTxt1.y = 331;
         addChild(_pZbZhidescriptTxt1);
         _pZbZhidescriptTxt = ComponentFactory.Instance.creatComponentByStylename("pZbZhidescriptTxt");
         _pZbZhidescriptTxt.x = 103;
         _pZbZhidescriptTxt.y = 362;
         addChild(_pZbZhidescriptTxt);
      }
      
      public function update(param1:Object) : void
      {
         if(!param1)
         {
            _pdescriptTxt1.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt1");
            _pdescriptTxt3.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.pdescriptTxt3");
            _pZbZhidescriptTxt1.text = "0";
            _pZbZhidescriptTxt.text = "0";
            return;
         }
         _pdescriptTxt1.text = String(param1.curLve);
         _pdescriptTxt3.text = String(param1.upGrdPro);
         _pZbZhidescriptTxt1.text = String(param1.levHe);
         _pZbZhidescriptTxt.text = String(param1.proHe);
      }
      
      public function dispose() : void
      {
         if(_title1)
         {
            ObjectUtils.disposeObject(_title1);
         }
         _title1 = null;
         if(_title2)
         {
            ObjectUtils.disposeObject(_title2);
         }
         _title2 = null;
         if(_titleTxt1)
         {
            ObjectUtils.disposeObject(_titleTxt1);
         }
         _titleTxt1 = null;
         if(_titleTxt2)
         {
            ObjectUtils.disposeObject(_titleTxt2);
         }
         _titleTxt2 = null;
         if(_descriptTxt)
         {
            ObjectUtils.disposeObject(_descriptTxt);
         }
         _descriptTxt = null;
         if(_pdescriptTxt1)
         {
            ObjectUtils.disposeObject(_pdescriptTxt1);
         }
         _pdescriptTxt1 = null;
         if(_pdescriptTxt2)
         {
            ObjectUtils.disposeObject(_pdescriptTxt2);
         }
         _pdescriptTxt2 = null;
         if(_pdescriptTxt3)
         {
            ObjectUtils.disposeObject(_pdescriptTxt3);
         }
         _pdescriptTxt3 = null;
         if(_pZbdescriptTxt)
         {
            ObjectUtils.disposeObject(_pZbdescriptTxt);
         }
         _pZbdescriptTxt = null;
         if(_pZbdescriptTxt1)
         {
            ObjectUtils.disposeObject(_pZbdescriptTxt1);
         }
         _pZbdescriptTxt1 = null;
         if(_pZbZhidescriptTxt1)
         {
            ObjectUtils.disposeObject(_pZbZhidescriptTxt1);
         }
         _pZbdescriptTxt1 = null;
         if(_pZbZhidescriptTxt)
         {
            ObjectUtils.disposeObject(_pZbZhidescriptTxt);
         }
         _pZbZhidescriptTxt = null;
      }
   }
}
