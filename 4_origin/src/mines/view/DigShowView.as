package mines.view
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import mines.MinesManager;
   import mines.analyzer.DropItemInfo;
   import mines.mornui.view.DigShowViewUI;
   import morn.core.handlers.Handler;
   
   public class DigShowView extends DigShowViewUI
   {
       
      
      public function DigShowView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         closeBtn.clickHandler = new Handler(dispose);
         titleLabel.text = LanguageMgr.GetTranslation("ddt.mines.digShowView.titleInfo");
         floor1Label.text = LanguageMgr.GetTranslation("ddt.mines.digShowView.floor",1);
         floor2Label.text = LanguageMgr.GetTranslation("ddt.mines.digShowView.floor",2);
         floor3Label.text = LanguageMgr.GetTranslation("ddt.mines.digShowView.floor",3);
         floor4Label.text = LanguageMgr.GetTranslation("ddt.mines.digShowView.floor",4);
         floor5Label.text = LanguageMgr.GetTranslation("ddt.mines.digShowView.floor",5);
         mines1Label.text = checkDrop(0);
         mines2Label.text = checkDrop(1);
         mines3Label.text = checkDrop(2);
         mines4Label.text = checkDrop(3);
         mines5Label.text = checkDrop(4);
      }
      
      public function checkDrop(index:int) : String
      {
         var i:int = 0;
         var j:int = 0;
         var item:* = null;
         var list:Array = ItemManager.Instance.getMinesPropByPro();
         var info:DropItemInfo = MinesManager.instance.model.dropList[index];
         var nameList:String = "";
         var arr:Array = [info.Rate1,info.Rate2,info.Rate3,info.Rate4,info.Rate5,info.Rate6,info.Rate7,info.Rate8,info.Rate9,info.Rate10,info.Rate11];
         var arrIndex:int = 0;
         for(i = arr.length - 1; i > 0; )
         {
            if(arr[i] != 0)
            {
               arrIndex = i + 1;
               break;
            }
            i--;
         }
         j = 0;
         while(j < list.length)
         {
            item = list[j];
            if(int(item.Property1) <= arrIndex)
            {
               if(nameList == "")
               {
                  nameList = item.Name;
               }
               else
               {
                  nameList = nameList + "," + item.Name;
               }
            }
            j++;
         }
         return nameList;
      }
   }
}
