package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class TofflistTitleInfoItem extends Sprite
   {
       
      
      protected var _title:FilterFrameText;
      
      protected var _requireText:FilterFrameText;
      
      protected var _contentText:FilterFrameText;
      
      protected var _title1:FilterFrameText;
      
      protected var _title2:FilterFrameText;
      
      protected var _title3:FilterFrameText;
      
      protected var _title4:FilterFrameText;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function TofflistTitleInfoItem()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("toffilist.titleInfoTxt");
         _title.text = LanguageMgr.GetTranslation("toffilist.titleInfo.leftTitleText");
         addChild(_title);
         _requireText = ComponentFactory.Instance.creatComponentByStylename("toffilist.require");
         _requireText.text = LanguageMgr.GetTranslation("toffilist.titleInfo.requireText");
         addChild(_requireText);
         _contentText = ComponentFactory.Instance.creatComponentByStylename("toffilist.content");
         _contentText.text = LanguageMgr.GetTranslation("toffilist.titleInfo.leftContentText");
         addChild(_contentText);
         _title1 = ComponentFactory.Instance.creatComponentByStylename("toffilist.titleTxt1");
         _title1.text = LanguageMgr.GetTranslation("hall.player.titleText0");
         addChild(_title1);
         _title2 = ComponentFactory.Instance.creatComponentByStylename("toffilist.titleTxt2");
         _title2.text = LanguageMgr.GetTranslation("hall.player.titleText1");
         addChild(_title2);
         _title3 = ComponentFactory.Instance.creatComponentByStylename("toffilist.titleTxt3");
         _title3.text = LanguageMgr.GetTranslation("hall.player.titleText2");
         addChild(_title3);
         _title4 = ComponentFactory.Instance.creatComponentByStylename("toffilist.titleTxt4");
         _title4.text = LanguageMgr.GetTranslation("hall.player.titleText7");
         addChild(_title4);
      }
      
      public function setData(param1:Object) : void
      {
         _title.text = param1.titleText;
         _contentText.text = param1.content;
         _requireText.text = param1.rightRequiredText;
         _title1.textFormatStyle = param1.title1;
         _title2.textFormatStyle = param1.title2;
         _title3.textFormatStyle = param1.title3;
         _title4.textFormatStyle = param1.title4;
         _title1.text = param1.titleName1;
         _title2.text = param1.titleName2;
         _title3.text = param1.titleName3;
         _title4.text = param1.titleName4;
         _title1.x = _title2.x;
      }
      
      public function dispose() : void
      {
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_requireText)
         {
            ObjectUtils.disposeObject(_requireText);
         }
         _requireText = null;
         if(_contentText)
         {
            ObjectUtils.disposeObject(_contentText);
         }
         _contentText = null;
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
         if(_title3)
         {
            ObjectUtils.disposeObject(_title3);
         }
         _title3 = null;
         if(_title4)
         {
            ObjectUtils.disposeObject(_title4);
         }
         _title4 = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
