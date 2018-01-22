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
      
      public function checkDrop(param1:int) : String
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Array = ItemManager.Instance.getMinesPropByPro();
         var _loc9_:DropItemInfo = MinesManager.instance.model.dropList[param1];
         var _loc6_:String = "";
         var _loc2_:Array = [_loc9_.Rate1,_loc9_.Rate2,_loc9_.Rate3,_loc9_.Rate4,_loc9_.Rate5,_loc9_.Rate6,_loc9_.Rate7,_loc9_.Rate8,_loc9_.Rate9,_loc9_.Rate10,_loc9_.Rate11];
         var _loc7_:int = 0;
         _loc8_ = _loc2_.length - 1;
         while(_loc8_ > 0)
         {
            if(_loc2_[_loc8_] != 0)
            {
               _loc7_ = _loc8_ + 1;
               break;
            }
            _loc8_--;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_];
            if(int(_loc3_.Property1) <= _loc7_)
            {
               if(_loc6_ == "")
               {
                  _loc6_ = _loc3_.Name;
               }
               else
               {
                  _loc6_ = _loc6_ + "," + _loc3_.Name;
               }
            }
            _loc5_++;
         }
         return _loc6_;
      }
   }
}
