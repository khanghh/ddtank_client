package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class RechargeAlertTxt extends Sprite implements Disposeable
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _title:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      public function RechargeAlertTxt()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creat("VipRechargeLV.titleTxt");
         addChild(_title);
         _content = ComponentFactory.Instance.creat("VipRechargeLV.contentTxt");
         addChild(_content);
      }
      
      public function set AlertContent(vipLev:int) : void
      {
         _title.text = getAlertTitle(vipLev);
         _content.text = getAlertTxt(vipLev);
      }
      
      private function getAlertTxt(lev:int) : String
      {
         var resultString:String = "";
         switch(int(lev) - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               resultString = resultString + ("1、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1Param0")) + "\n");
               resultString = resultString + ("2、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2Param")) + "\n");
               resultString = resultString + ("3、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3Param")) + "\n");
               resultString = resultString + ("4、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4Param0")) + "\n");
               resultString = resultString + ("5、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5Param0")) + "\n");
               resultString = resultString + ("6、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent8") + "\n");
               resultString = resultString + ("7、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent9") + "\n");
               resultString = resultString + ("8、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent10",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent10Param0")) + "\n");
               resultString = resultString + ("9、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent11",";") + "\n");
               resultString = resultString + ("10、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent12",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent12Param0"),LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent12Param2")) + "\n");
               resultString = resultString + ("11、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.gainHotSpringBathrobe") + "\n");
               resultString = resultString + "            \n";
               break;
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               resultString = resultString + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent13") + "\n");
               resultString = resultString + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent14") + "\n");
               resultString = resultString + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent15") + "\n");
               resultString = resultString + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent16") + "\n");
               resultString = resultString + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent17") + "\n");
               resultString = resultString + ("6、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1Param1")) + "\n");
               resultString = resultString + ("7、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4Param1")) + "\n");
               resultString = resultString + ("8、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3Param")) + "\n");
               resultString = resultString + ("9、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2Param")) + "\n");
               resultString = resultString + ("10、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent8") + "\n");
               resultString = resultString + ("11、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5Param1")) + "\n");
               resultString = resultString + ("12、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent11",";") + "\n");
               resultString = resultString + ("13、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent9") + "\n");
               resultString = resultString + ("14、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.gainHotSpringBathrobe") + "\n");
               resultString = resultString + ("15、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.FireworksWeekPacks") + "\n");
               resultString = resultString + ("16、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.ExclusiveTitleAndClothing") + "\n");
               resultString = resultString + "            \n";
         }
         return resultString;
      }
      
      private function getAlertTitle(lev:int) : String
      {
         var resultString:String = "";
         switch(int(lev) - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               resultString = LanguageMgr.GetTranslation("tank.vip.rechargeAlertTitle",6);
               break;
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               resultString = LanguageMgr.GetTranslation("tank.vip.rechargeAlertEndTitle",15);
         }
         return resultString;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
      }
   }
}
