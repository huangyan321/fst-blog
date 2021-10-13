import Vue from 'vue';
import { Breadcrumb,
  BreadcrumbItem,
  Dropdown,
  DropdownMenu,
  DropdownItem,
  Icon,
  MenuItem,
  Scrollbar,
  Menu,
  Submenu,
  Upload,
  Form,
  Input,
  Select,
  Option,
  Col,
  TimePicker,
  FormItem,
  Switch,
  Checkbox,
  RadioGroup,
  Radio,
  Button,
  Row,
  Alert,
  Table,
  TableColumn,
  Tag,
  Tree,
  Loading,
  MessageBox,
  Message,
  Notification,
  Dialog,
  Card,
  Pagination,
  Tooltip,
  Cascader,
  Tabs,
  TabPane,
  Step,
  Steps,
  Rate
} from "element-ui"
Vue.use(Breadcrumb)
Vue.use(BreadcrumbItem)
Vue.use(Dropdown)
Vue.use(DropdownMenu)
Vue.use(DropdownItem)
Vue.use(Icon)
Vue.use(MenuItem)
Vue.use(Scrollbar)
Vue.use(Menu)
Vue.use(Submenu)
Vue.use(Upload)
Vue.use(Form)
Vue.use(Input)
Vue.use(Select)
Vue.use(Option)
Vue.use(Col)
Vue.use(TimePicker)
Vue.use(FormItem)
Vue.use(Switch)
Vue.use(Checkbox)
Vue.use(RadioGroup)
Vue.use(Radio)
Vue.use(Button)
Vue.use(Row)
Vue.use(Alert)
Vue.use(Row)
Vue.use(Table)
Vue.use(TableColumn)
Vue.use(Tag)
Vue.use(Tree)
Vue.use(Dialog)
Vue.use(Card)
Vue.use(Pagination)
Vue.use(Tooltip)
Vue.use(Cascader)
Vue.use(Tabs)
Vue.use(TabPane)
Vue.use(Step)
Vue.use(Steps)
Vue.use(Rate)
Vue.prototype.$loading = Loading.service;
Vue.prototype.$msgbox = MessageBox;
Vue.prototype.$alert = MessageBox.alert;
Vue.prototype.$confirm = MessageBox.confirm;
Vue.prototype.$prompt = MessageBox.prompt;
Vue.prototype.$notify = Notification;
Vue.prototype.$message = Message;
