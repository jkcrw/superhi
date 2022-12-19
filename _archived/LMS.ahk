; Lazy Man's Shorthand
; Jak Crow
; Created: 2017/07/23

;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK SETUP
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#Hotstring EndChars ( )[]{}:`;",.?!=%

#Include Canned Info.ahk

Suspend On

FastText(text) {
    Clipboard :=
    Clipboard := text
    ClipWait
    Sleep 10
    Send ^v
    Sleep 10
    Return
}

;┌─────────────────────────────────────────────────────────────────────────────
;│ WRAPPING
;│ System-wide quote/bracket/brace/paren wrap (like in Sublime text).
;└─────────────────────────────────────────────────────────────────────────────
^!+#h::
#Include AddHotstring.ahk
Return

#IfWinActive ^((?!Sublime Text).)*$
^(::
    WrapWith("(", ")")
    Return

^[::
    WrapWith("[", "]")
    Return
^{::
    WrapWith("{", "}")
    Return
^"::
    WrapWith("""", """")
    Return
#IfWinActive
; %::
;     WrapWith("%", "%")
;     Return

WrapWith(pre_string, post_string) {
    Sleep 25
    SavedClip := Clipboard
    Sleep 25
    Clipboard := 
    Send ^c
    Sleep 25
    Clipboard := pre_string . Clipboard . post_string
    Clipwait
    Sleep 25
    Send ^v
    Sleep 25
    Clipboard := SavedClip
    Return
}

;┌─────────────────────────────────────────────────────────────────────────────
;│ SOKKI
;│ Sources:
;│ http://www.oxforddictionaries.com/words/what-can-corpus-tell-us-about-language
;│ http://forum.colemak.com/viewtopic.php?pid=13768
;│ http://www.wordfrequency.info/free.asp
;└─────────────────────────────────────────────────────────────────────────────
#Hotstring O *
; Personal info
::/nm::
    FastText(full_name)
    Return
::/ft::
    FastText(first_name)
    Return
::/md::
    FastText(middle_name)
    Return
::/lt::
    FastText(last_name)
    Return
::/dob::
    FastText(date_of_birth)
    Return
::/eml::
    FastText(email)
    Return
::/fon::
    FastText(phone)
    Return
::/adr::
    FastText(address)
    Return
::/str::
    FastText(street)
    Return
::/cy::
    FastText(city)
    Return
::/zp::
    FastText(zip)
    Return
::/ladr::
    FastText(long_address)
    Return

; Time and Date Expansions
::/tm::
    FormatTime, CurrentDateTime,, HH:mm:ss
    SendInput %CurrentDateTime%
    Return
::/nw::
    FormatTime, CurrentDateTime,, yyyy/MM/dd HH:mm:ss
    SendInput %CurrentDateTime%
    Return
::/dt::
    FormatTime, CurrentDateTime,, yyyy/MM/dd
    SendInput %CurrentDateTime%
    Return
:*0:/pdt::
    FormatTime, CurrentDateTime,, yyyy/MM/dd
    SendInput (%CurrentDateTime%){Space}
    Return
::/ddt::
    FormatTime, CurrentDateTime,, yyyy-MM-dd
    SendInput %CurrentDateTime%
    Return
::/ldt::
    FormatTime, CurrentDateTime,, MMMM d, yyyy
    SendInput %CurrentDateTime%
    Return
::/wdt::
    FormatTime, CurrentDateTime,, ddd MM/dd/yyyy
    SendInput %CurrentDateTime%
    Return
::/dyti::
    prefix := "1900/01/01 "
    FormatTime, CurrentDateTime,, HH:mm:ss
    CurrentDateTime := prefix . CurrentDateTime
    SendInput %CurrentDateTime%
    Return
::/nhti::
    prefix := "1900/01/02 "
    FormatTime, CurrentDateTime,, HH:mm:ss
    CurrentDateTime := prefix . CurrentDateTime
    SendInput %CurrentDateTime%
    Return

; SYMBOLS
; Math/Engineering
#Hotstring C ?
::/tis::×
::/deg::°
::/pm::±
::/let::≤
::/get::≥
::/net::≠
::/apx::≈
::/blt::•
::/dot::·
::/end::–
::/emd::—
::/sqrt::√
::/prop::∝
::/xf::⇒
::/db::÷
::/ang::Å
::/eo::∈
::/neo::∉
::/if::∞
::/diam::⌀
::/yen::¥
::/rtm::®
::/rr::→
::/lr::←
::/ur::↑
::/dr::↓
::/lod::ಠ_ಠ
^!+/::
    Send ¿
    Return
; Greek (long)
#Hotstring *0
::/alpha::α
::/beta::β
::/Gamma::Γ
::/gamma::γ
::/Delta::Δ
::/delta::δ
::/epsilon::ε
::/zeta::ζ
::/eta::η
::/Theta::Θ
::/theta::θ
::/iota::ι
::/kappa::κ
::/Lambda::Λ
::/lambda::λ
::/mu::μ
::/Xi::Ξ
::/xi::ξ
::/Pi::Π
::/pi::π
::/rho::ρ
::/Sigma::Σ
::/sigma::σ
::/tau::τ
::/upsilon::υ
::/Phi::Φ
::/phi::φ
::/chi::χ
::/Psi::Ψ
::/psi::ψ
::/Omega::Ω
::/Ohm::Ω
::/omega::ω
; Greek (short)
::/a::α
::/b::β
::/G::Γ
::/g::γ
::/D::Δ
::/d::δ
::/e::ε
::/z::ζ
::/E::η
::/T::Θ
::/t::θ
::/i::ι
::/k::κ
::/L::Λ
::/l::λ
::/m::μ
::/n::ν
::/X::Ξ
::/x::ξ
::/Pi::Π
::/pi::π
::/r::ρ
::/S::Σ
::/s::σ
::/t::τ
::/u::υ
::/Phi::Φ
::/phi::φ
::/chi::χ
::/Psi::Ψ
::/psi::ψ
::/O::Ω
::/o::ω

#Hotstring O0 C0 ?0 *0
; #Hotstring O SE K5 Z ; For Epistory
; #Hotstring EndChars -( )[]{}:`;"\,.?!_=%'
; #IfWinActive, Epistory
; ^!+#f::
;     Send spark
;     Return
; ^!+#g::
;     Send fire
;     Return
; ^!+#s::
;     Send ice
;     Return
; ^!+#,::
;     Send wind
;     Return
; #IfWinActive

; ; Countries of world (ISO ALPHA-2 codes) (start counting from here)
; ::'af::Afghanistan
; ::'ax::Aland Islands
; ::'al::Albania
; ::'dz::Algeria
; ::'as::American Samoa
; ::'ad::Andorra
; ::'ao::Angola
; ::'ai::Anguilla
; ::'aq::Antarctica
; ::'ag::Antigua and Barbuda
; ::'ar::Argentina
; ::'am::Armenia
; ::'aw::Aruba
; ::'au::Australia
; ::'at::Austria
; ::'az::Azerbaijan
; ::'bs::Bahamas
; ::'bh::Bahrain
; ::'bd::Bangladesh
; ::'bb::Barbados
; ::'by::Belarus
; ::'be::Belgium
; ::'bz::Belize
; ::'bj::Benin
; ::'bm::Bermuda
; ::'bt::Bhutan
; ::'bo::Bolivia
; ::'ba::Bosnia and Herzegovina
; ::'bw::Botswana
; ::'bv::Bouvet Island
; ::'br::Brazil
; ::'vg::British Virgin Islands
; ::'io::British Indian Ocean Territory
; ::'bn::Brunei Darussalam
; ::'bg::Bulgaria
; ::'bf::Burkina Faso
; ::'bi::Burundi
; ::'kh::Cambodia
; ::'cm::Cameroon
; ::'ca::Canada
; ::'cv::Cape Verde
; ::'ky::Cayman Islands
; ::'cf::Central African Republic
; ::'td::Chad
; ::'cl::Chile
; ::'cn::China
; ::'hk::Hong Kong, Special Administrative Region of China
; ::'mo::Macao, Special Administrative Region of China
; ::'cx::Christmas Island
; ::'cc::Cocos (Keeling) Islands
; ::'co::Colombia
; ::'km::Comoros
; ::'cg::Congo (Brazzaville)
; ::'cd::Congo, Democratic Republic of the
; ::'ck::Cook Islands
; ::'cr::Costa Rica
; ::'ci::Côte d'Ivoire
; ::'hr::Croatia
; ::'cu::Cuba
; ::'cy::Cyprus
; ::'cz::Czech Republic
; ::'dk::Denmark
; ::'dj::Djibouti
; ::'dm::Dominica
; ::'do::Dominican Republic
; ::'ec::Ecuador
; ::'eg::Egypt
; ::'sv::El Salvador
; ::'gq::Equatorial Guinea
; ::'er::Eritrea
; ::'ee::Estonia
; ::'et::Ethiopia
; ::'fk::Falkland Islands (Malvinas)
; ::'fo::Faroe Islands
; ::'fj::Fiji
; ::'fi::Finland
; ::'fr::France
; ::'gf::French Guiana
; ::'pf::French Polynesia
; ::'tf::French Southern Territories
; ::'ga::Gabon
; ::'gm::Gambia
; ::'ge::Georgia
; ::'de::Germany
; ::'gh::Ghana
; ::'gi::Gibraltar
; ::'gr::Greece
; ::'gl::Greenland
; ::'gd::Grenada
; ::'gp::Guadeloupe
; ::'gu::Guam
; ::'gt::Guatemala
; ::'gg::Guernsey
; ::'gn::Guinea
; ::'gw::Guinea-Bissau
; ::'gy::Guyana
; ::'ht::Haiti
; ::'hm::Heard Island and Mcdonald Islands
; ::'va::Holy See (Vatican City State)
; ::'hn::Honduras
; ::'hu::Hungary
; ::'is::Iceland
; ::'in::India
; ::'id::Indonesia
; ::'ir::Iran, Islamic Republic of
; ::'iq::Iraq
; ::'ie::Ireland
; ::'im::Isle of Man
; ::'il::Israel
; ::'it::Italy
; ::'jm::Jamaica
; ::'jp::Japan
; ::'je::Jersey
; ::'jo::Jordan
; ::'kz::Kazakhstan
; ::'ke::Kenya
; ::'ki::Kiribati
; ::'kp::Korea, Democratic People's Republic of
; ::'kr::Korea, Republic of
; ::'kw::Kuwait
; ::'kg::Kyrgyzstan
; ::'la::Lao PDR
; ::'lv::Latvia
; ::'lb::Lebanon
; ::'ls::Lesotho
; ::'lr::Liberia
; ::'ly::Libya
; ::'li::Liechtenstein
; ::'lt::Lithuania
; ::'lu::Luxembourg
; ::'mk::Macedonia, Republic of
; ::'mg::Madagascar
; ::'mw::Malawi
; ::'my::Malaysia
; ::'mv::Maldives
; ::'ml::Mali
; ::'mt::Malta
; ::'mh::Marshall Islands
; ::'mq::Martinique
; ::'mr::Mauritania
; ::'mu::Mauritius
; ::'yt::Mayotte
; ::'mx::Mexico
; ::'fm::Micronesia, Federated States of
; ::'md::Moldova
; ::'mc::Monaco
; ::'mn::Mongolia
; ::'me::Montenegro
; ::'ms::Montserrat
; ::'ma::Morocco
; ::'mz::Mozambique
; ::'mm::Myanmar
; ::'na::Namibia
; ::'nr::Nauru
; ::'np::Nepal
; ::'nl::Netherlands
; ::'an::Netherlands Antilles
; ::'nc::New Caledonia
; ::'nz::New Zealand
; ::'ni::Nicaragua
; ::'ne::Niger
; ::'ng::Nigeria
; ::'nu::Niue
; ::'nf::Norfolk Island
; ::'mp::Northern Mariana Islands
; ::'no::Norway
; ::'om::Oman
; ::'pk::Pakistan
; ::'pw::Palau
; ::'ps::Palestinian Territory, Occupied
; ::'pa::Panama
; ::'pg::Papua New Guinea
; ::'py::Paraguay
; ::'pe::Peru
; ::'ph::Philippines
; ::'pn::Pitcairn
; ::'pl::Poland
; ::'pt::Portugal
; ::'pr::Puerto Rico
; ::'qa::Qatar
; ::'re::Réunion
; ::'ro::Romania
; ::'ru::Russian Federation
; ::'rw::Rwanda
; ::'bl::Saint-Barthélemy
; ::'sh::Saint Helena
; ::'kn::Saint Kitts and Nevis
; ::'lc::Saint Lucia
; ::'mf::Saint-Martin (French part)
; ::'pm::Saint Pierre and Miquelon
; ::'vc::Saint Vincent and Grenadines
; ::'ws::Samoa
; ::'sm::San Marino
; ::'st::Sao Tome and Principe
; ::'sa::Saudi Arabia
; ::'sn::Senegal
; ::'rs::Serbia
; ::'sc::Seychelles
; ::'sl::Sierra Leone
; ::'sg::Singapore
; ::'sk::Slovakia
; ::'si::Slovenia
; ::'sb::Solomon Islands
; ::'so::Somalia
; ::'za::South Africa
; ::'gs::South Georgia and the South Sandwich Islands
; ::'ss::South Sudan
; ::'es::Spain
; ::'lk::Sri Lanka
; ::'sd::Sudan
; ::'sr::Suriname *
; ::'sj::Svalbard and Jan Mayen Islands
; ::'sz::Swaziland
; ::'se::Sweden
; ::'ch::Switzerland
; ::'sy::Syrian Arab Republic (Syria)
; ::'tw::Taiwan, Republic of China
; ::'tj::Tajikistan
; ::'tz::Tanzania *, United Republic of
; ::'th::Thailand
; ::'tl::Timor-Leste
; ::'tg::Togo
; ::'tk::Tokelau
; ::'to::Tonga
; ::'tt::Trinidad and Tobago
; ::'tn::Tunisia
; ::'tr::Turkey
; ::'tm::Turkmenistan
; ::'tc::Turks and Caicos Islands
; ::'tv::Tuvalu
; ::'ug::Uganda
; ::'ua::Ukraine
; ::'ae::United Arab Emirates
; ::'gb::United Kingdom
; ::'us::United States of America
; ::'um::United States Minor Outlying Islands
; ::'uy::Uruguay
; ::'uz::Uzbekistan
; ::'vu::Vanuatu
; ::'ve::Venezuela (Bolivarian Republic of)
; ::'vn::Viet Nam
; ::'vi::Virgin Islands, US
; ::'wf::Wallis and Futuna Islands
; ::'eh::Western Sahara
; ::'ye::Yemen
; ::'zm::Zambia
; ::'zw::Zimbabwe
; ; Periodic table of elements
; ::\h::hydrogen
; ::\he::helium
; ::\li::lithium
; ::\be::beryllium
; ::\b::boron
; ::\c::carbon
; ::\n::nitrogen
; ::\o::oxygen
; ::\f::fluorine
; ::\ne::neon
; ::\na::sodium
; ::\mg::magnesium
; ::\al::aluminum
; ::\si::silicon
; ::\p::phosphorus
; ::\s::sulfur
; ::\cl::chlorine
; ::\ar::argon
; ::\k::potassium
; ::\ca::calcium
; ::\sc::scandium
; ::\ti::titanium
; ::\v::vanadium
; ::\cr::chromium
; ::\mn::manganese
; ::\fe::iron
; ::\co::cobalt
; ::\ni::nickel
; ::\cu::copper
; ::\zn::zinc
; ::\ga::gallium
; ::\ge::germanium
; ::\as::arsenic
; ::\se::selenium
; ::\br::bromine
; ::\kr::krypton
; ::\rb::rubidium
; ::\sr::strontium
; ::\y::yttrium
; ::\zr::zirconium
; ::\nb::niobium
; ::\mo::molybdenum
; ::\tc::technetium
; ::\ru::ruthenium
; ::\rh::rhodium
; ::\pd::palladium
; ::\ag::silver
; ::\cd::cadmium
; ::\in::indium
; ::\sn::tin
; ::\sb::antimony
; ::\te::tellurium
; ::\i::iodine
; ::\xe::xenon
; ::\cs::cesium
; ::\ba::barium
; ::\la::lanthanum
; ::\ce::cerium
; ::\pr::praseodymium
; ::\nd::neodymium
; ::\pm::promethium
; ::\sm::samarium
; ::\eu::europium
; ::\gd::gadolinium
; ::\tb::terbium
; ::\dy::dysprosium
; ::\ho::holmium
; ::\er::erbium
; ::\tm::thulium
; ::\yb::ytterbium
; ::\lu::lutetium
; ::\hf::hafnium
; ::\ta::tantalum
; ::\w::tungsten
; ::\re::rhenium
; ::\os::osmium
; ::\ir::iridium
; ::\pt::platinum
; ::\au::gold
; ::\hg::mercury
; ::\tl::thallium
; ::\pb::lead
; ::\bi::bismuth
; ::\po::polonium
; ::\at::astatine
; ::\rn::radon
; ::\fr::francium
; ::\ra::radium
; ::\ac::actinium
; ::\th::thorium
; ::\pa::protactinium
; ::\u::uranium
; ::\np::neptunium
; ::\pu::plutonium
; ::\am::americium
; ::\cm::curium
; ::\bk::berkelium
; ::\cf::californium
; ::\es::einsteinium
; ::\fm::fermium
; ::\md::mendelevium
; ::\no::nobelium
; ::\lr::lawrencium
; ::\rf::rutherfordium
; ::\db::dubnium
; ::\sg::seaborgium
; ::\bh::bohrium
; ::\hs::hassium
; ::\mt::meitnerium
; ::\ds::darmstadtium
; ::\rg::roentgenium
; ::\cn::copernicium
; ::\nh::nihonium
; ::\fl::flerovium
; ::\mc::moscovium
; ::\lv::livermorium
; ::\ts::tennessine
; ::\og::oganesson
; ::\xh::hydrogen (H)
; ::\xhe::helium (He)
; ::\xli::lithium (Li)
; ::\xbe::beryllium (Be)
; ::\xb::boron (B)
; ::\xc::carbon (C)
; ::\xn::nitrogen (N)
; ::\xo::oxygen (O)
; ::\xf::fluorine (F)
; ::\xne::neon (Ne)
; ::\xna::sodium (Na)
; ::\xmg::magnesium (Mg)
; ::\xal::aluminum (Al)
; ::\xsi::silicon (Si)
; ::\xp::phosphorus (P)
; ::\xs::sulfur (S)
; ::\xcl::chlorine (Cl)
; ::\xar::argon (Ar)
; ::\xk::potassium (K)
; ::\xca::calcium (Ca)
; ::\xsc::scandium (Sc)
; ::\xti::titanium (Ti)
; ::\xv::vanadium (V)
; ::\xcr::chromium (Cr)
; ::\xmn::manganese (Mn)
; ::\xfe::iron (Fe)
; ::\xco::cobalt (Co)
; ::\xni::nickel (Ni)
; ::\xcu::copper (Cu)
; ::\xzn::zinc (Zn)
; ::\xga::gallium (Ga)
; ::\xge::germanium (Ge)
; ::\xas::arsenic (As)
; ::\xse::selenium (Se)
; ::\xbr::bromine (Br)
; ::\xkr::krypton (Kr)
; ::\xrb::rubidium (Rb)
; ::\xsr::strontium (Sr)
; ::\xy::yttrium (Y)
; ::\xzr::zirconium (Zr)
; ::\xnb::niobium (Nb)
; ::\xmo::molybdenum (Mo)
; ::\xtc::technetium (Tc)
; ::\xru::ruthenium (Ru)
; ::\xrh::rhodium (Rh)
; ::\xpd::palladium (Pd)
; ::\xag::silver (Ag)
; ::\xcd::cadmium (Cd)
; ::\xin::indium (In)
; ::\xsn::tin (Sn)
; ::\xsb::antimony (Sb)
; ::\xte::tellurium (Te)
; ::\xi::iodine (I)
; ::\xxe::xenon (Xe)
; ::\xcs::cesium (Cs)
; ::\xba::barium (Ba)
; ::\xla::lanthanum (La)
; ::\xce::cerium (Ce)
; ::\xpr::praseodymium (Pr)
; ::\xnd::neodymium (Nd)
; ::\xpm::promethium (Pm)
; ::\xsm::samarium (Sm)
; ::\xeu::europium (Eu)
; ::\xgd::gadolinium (Gd)
; ::\xtb::terbium (Tb)
; ::\xdy::dysprosium (Dy)
; ::\xho::holmium (Ho)
; ::\xer::erbium (Er)
; ::\xtm::thulium (Tm)
; ::\xyb::ytterbium (Yb)
; ::\xlu::lutetium (Lu)
; ::\xhf::hafnium (Hf)
; ::\xta::tantalum (Ta)
; ::\xw::tungsten (W)
; ::\xre::rhenium (Re)
; ::\xos::osmium (Os)
; ::\xir::iridium (Ir)
; ::\xpt::platinum (Pt)
; ::\xau::gold (Au)
; ::\xhg::mercury (Hg)
; ::\xtl::thallium (Tl)
; ::\xpb::lead (Pb)
; ::\xbi::bismuth (Bi)
; ::\xpo::polonium (Po)
; ::\xat::astatine (At)
; ::\xrn::radon (Rn)
; ::\xfr::francium (Fr)
; ::\xra::radium (Ra)
; ::\xac::actinium (Ac)
; ::\xth::thorium (Th)
; ::\xpa::protactinium (Pa)
; ::\xu::uranium (U)
; ::\xnp::neptunium (Np)
; ::\xpu::plutonium (Pu)
; ::\xam::americium (Am)
; ::\xcm::curium (Cm)
; ::\xbk::berkelium (Bk)
; ::\xcf::californium (Cf)
; ::\xes::einsteinium (Es)
; ::\xfm::fermium (Fm)
; ::\xmd::mendelevium (Md)
; ::\xno::nobelium (No)
; ::\xlr::lawrencium (Lr)
; ::\xrf::rutherfordium (Rf)
; ::\xdb::dubnium (Db)
; ::\xsg::seaborgium (Sg)
; ::\xbh::bohrium (Bh)
; ::\xhs::hassium (Hs)
; ::\xmt::meitnerium (Mt)
; ::\xds::darmstadtium (Ds)
; ::\xrg::roentgenium (Rg)
; ::\xcn::copernicium (Cn)
; ::\xnh::nihonium (Nh)
; ::\xfl::flerovium (Fl)
; ::\xmc::moscovium (Mc)
; ::\xlv::livermorium (Lv)
; ::\xts::tennessine (Ts)
; ::\xog::oganesson (Og)
; ; Regular words
; :*:/yoru::夜
; :*:/asa::朝
; ::/su::Sunday
; ::/mo::Monday
; ::/tu::Tuesday
; ::/we::Wednesday
; ::/th::Thursday
; ::/fr::Friday
; ::/sa::Saturday
; ::/sus::Sundays
; ::/mos::Mondays
; ::/tus::Tuesdays
; ::/wes::Wednesdays
; ::/ths::Thursdays
; ::/frs::Fridays
; ::/sas::Saturdays
; ::/ja::January
; ::/fe::February
; ::/mr::March
; ::/ap::April
; ; May is covered by the word 'may' = 'm'
; ::/jn::June
; ::/jl::July
; ::/au::August
; ::/se::September
; ::/oc::October
; ::/no::November
; ::/de::December
; ::/1::first
; ::/2::second
; ::/3::third
; ::/4::fourth
; ::/5::fifth
; ::/6::sixth
; ::/7::seventh
; ::/8::eighth
; ::/9::ninth
; ::/10::tenth
; ::/11::eleventh
; ::/12::twelfth
; ::/13::thirteenth
; ::/14::fourteenth
; ::/15::fifteenth
; ::/16::sixteenth
; ::/17::seventeenth
; ::0/::zero
; ::1/::one
; ::2/::two
; ::3/::three
; ::4/::four
; ::5/::five
; ::6/::six
; ::7/::seven
; ::8/::eight
; ::9/::nine
; ; Regular words
; :*:/yoru::夜
; :*:/asa::朝
; ::/su::Sunday
; ::/mo::Monday
; ::/tu::Tuesday
; ::/we::Wednesday
; ::/th::Thursday
; ::/fr::Friday
; ::/sa::Saturday
; ::/sus::Sundays
; ::/mos::Mondays
; ::/tus::Tuesdays
; ::/wes::Wednesdays
; ::/ths::Thursdays
; ::/frs::Fridays
; ::/sas::Saturdays
; ::/ja::January
; ::/fe::February
; ::/mr::March
; ::/ap::April
; ; May is covered by the word 'may' = 'm'
; ::/jn::June
; ::/jl::July
; ::/au::August
; ::/se::September
; ::/oc::October
; ::/no::November
; ::/de::December
; ::/1::first
; ::/2::second
; ::/3::third
; ::/4::fourth
; ::/5::fifth
; ::/6::sixth
; ::/7::seventh
; ::/8::eighth
; ::/9::ninth
; ::0/::zero
; ::1/::one
; ::2/::two
; ::3/::three
; ::4/::four
; ::5/::five
; ::6/::six
; ::7/::seven
; ::8/::eight
; ::9/::nine
; ::blt::able to ; Start alphabetization reorganizations here
; ::ab::about
; ::abe::about the
; ::bv::above
; ::bvl::above all
; ::bvkbl::above and below
; ::bve::above the
; ::ap/::access point
; ::aps/::access points
; ::oo::according
; ::oot::according to
; ::ooe1::according to Embodiment 1
; ::ooe1pi::according to Embodiment 1 of the present invention
; ::ooe10::according to Embodiment 10
; ::ooe10pi::according to Embodiment 10 of the present invention
; ::ooe2::according to Embodiment 2
; ::ooe2pi::according to Embodiment 2 of the present invention
; ::ooe3::according to Embodiment 3
; ::ooe3pi::according to Embodiment 3 of the present invention
; ::ooe4::according to Embodiment 4
; ::ooe4pi::according to Embodiment 4 of the present invention
; ::ooe5::according to Embodiment 5
; ::ooe5pi::according to Embodiment 5 of the present invention
; ::ooe6::according to Embodiment 6
; ::ooe6pi::according to Embodiment 6 of the present invention
; ::ooe7::according to Embodiment 7
; ::ooe7pi::according to Embodiment 7 of the present invention
; ::ooe8::according to Embodiment 8
; ::ooe8pi::according to Embodiment 8 of the present invention
; ::ooe9::according to Embodiment 9
; ::ooe9pi::according to Embodiment 9 of the present invention
; ::oote::according to the
; ::ooem::according to the embodiment
; ::ooempi::according to the embodiment of the present invention
; ::oope::according to the present embodiment
; ::oopi::according to the present invention
; ::ool::accordingly
; ::akt::account
; ::aktd::accounted
; ::aktg::accounting
; ::akts::accounts
; ::acv::achieve
; ::acvd::achieved
; ::acvm::achievement
; ::acvms::achievements
; ::acvs::achieves
; ::acvg::achieving
; ::ak::across
; ::ake::across the
; ::au::actual
; ::aul::actually
; ::dd::added
; ::dda::added a
; ::ddn::added an
; ::ddsf::added support for
; ::dde::added the
; ::ddte::added to the
; ::ddg::adding
; ::ddj::addition
; ::ddjl::additional
; ::djl::additional
; ::ddjll::additionally
; ::djll::additionally
; ::ddjs::additions
; ::adr::address
; ::adrd::addressed
; ::adrs::addresses
; ::adrg::addressing
; ::ajt::adjacent
; ::ajtt::adjacent to
; ::ajtte::adjacent to the
; ::dj::adjust
; ::djd::adjusted
; ::djg::adjusting
; ::djm::adjustment
; ::djms::adjustments
; ::djs::adjusts
; ::afk::affect
; ::afkd::affected
; ::afkg::affecting
; ::afks::affects
; ::af::after
; ::afl::after all
; ::aftt::after that
; ::afe::after the
; ::ag::again
; ::agt::against
; ::agte::against the
; ::ah::ahead
; ::ahv::ahead of
; ::ahve::ahead of the
; ::l::all
; ::lil::all in all
; ::lv::all of
; ::lva::all of a
; ::lvy::all of my
; ::lvysf::all of myself
; ::lvtt::all of that
; ::lve::all of the
; ::lveot::all of the other
; ::lvxm::all of them
; ::lvxz::all of these
; ::lvts::all of this
; ::lvxs::all of those
; ::lvwc::all of which
; ::lvwcr::all of which are
; ::lvur::all of your
; ::leti::all the time
; ::lm::almost
; ::al::along
; ::ale::along the
; ::alwc::along which
; ::alwce::along which the
; ::alw::along with
; ::alwe::along with the
; ::alsd::alongside
; ::ldy::already
; ::lrh::alright
; ::ls::also
; ::lsb::also be
; ::ltv::alternative
; ::ltvl::alternatively
; ::ltvs::alternatives
; ::lxo::although
; ::ltog::altogether
; ::aw::always
; ::mggtb::am going to be
; ::mrc::America
; ::mrcn::American
; ::mrcns::Americans
; ::ao::among
; ::aoe::among the
; ::amt::amount
; ::amtv::amount of
; ::amtve::amount of the
; ::amts::amounts
; ::amtsv::amounts of
; ::amtsve::amounts of the
; ::k::and
; ::ka::and a
; ::kls::and also
; ::kr::and are
; ::krls::and are also
; ::krq::and are not
; ::krxf::and are therefore
; ::kbn::and been
; ::kc::and can
; ::kcb::and can be
; ::kie::and in the
; ::ks::and is
; ::kstn::and is then
; ::ksxf::and is therefore
; ::ktz::and it is
; ::kmb::and may be
; ::kne::and on the
; ::ktt::and that
; ::ke::and the
; ::klk::and the like
; ::ktn::and then
; ::kxf::and therefore
; ::kxz::and these
; ::kts::and this
; ::ko/::and/or
; ::ar::another
; ::negvn::any given
; ::negvnti::any given time
; ::nemr/::any more
; ::nev::any of
; ::nevtt::any of that
; ::neve::any of the
; ::nevxz::any of these
; ::nevxs::any of those
; ::nenv::any one of
; ::nenve::any one of the
; ::neot::any other
; ::nebd::anybody
; ::nemr::anymore
; ::nen::anyone
; ::nen'::anyone's
; ::netg::anything
; ::netgl::anything else
; ::neti::anytime
; ::ney::anyway
; ::neys::anyways
; ::newh::anywhere
; ::ppr::appear
; ::pprd::appeared
; ::pprg::appearing
; ::pprs::appears
; ::apl::applet
; ::apls::applets
; ::ap::application
; ::aps::applications
; ::ap'::application's
; ::apr::appropriate
; ::aprd::appropriated
; ::aprl::appropriately
; ::aprs::appropriates
; ::aprg::appropriating
; ::apx::approximate
; ::apxd::approximated
; ::apxl::approximately
; ::apxs::approximates
; ::apxg::approximating
; ::apxj::approximation
; ::apxjs::approximations
; ::r::are
; ::rls/::are also
; ::rajd::are arranged
; ::rfmd::are formed
; ::rmdfr::are made from
; ::rq::are not
; ::rn/::are now
; ::re::are the
; ::resa::are the same
; ::resaz::are the same as
; ::rtn::are then
; ::aa::area
; ::aas::areas
; ::r'::aren't
; ::ad::around
; ::ade::around the
; ::adu::around you
; ::aj::arrange
; ::ajd::arranged
; ::ajdne::arranged on the
; ::ajm::arrangement
; ::ajms::arrangements
; ::ajs::arranges
; ::ajg::arranging
; ::xrs::as a result
; ::xaw::as always
; ::xfx::as far as
; ::xfws::as follows
; ::xgdx::as good as
; ::xlx::as long as
; ::xlxe::as long as the
; ::xmn::as many
; ::xpbl::as possible
; ::xjnbl::as shown below
; ::xjni::as shown in
; ::xsx::as soon as
; ::xsxp::as soon as possible
; ::xe::as the
; ::xel::as well
; ::xwx::as well as
; ::xwxe::as well as the
; ::avepi::aspect of the present invention
; ::aec::at each
; ::als::at least
; ::alse::at least the
; ::aws::at once
; ::att::at that
; ::ae::at the
; ::aebmv::at the bottom of
; ::aebmve::at the bottom of the
; ::aesati::at the same time
; ::aetv::at the top of
; ::aetve::at the top of the
; ::ats::at this
; ::awc::at which
; ::awce::at which the
; ::ac::attach
; ::acd::attached
; ::acs::attaches
; ::acg::attaching
; ::acm::attachment
; ::acms::attachments
; ::af/::autofocus
; ::atm::automate
; ::atmd::automated
; ::atms::automates
; ::aom::automatic
; ::aoml::automatically
; ::atmg::automating
; ::atmj::automation
; ::atmjs::automations
; ::amb::automobile
; ::ambs::automobiles
; ::vlblt::availability
; ::vlbl::available
; ::avg::average
; ::avgd::averaged
; ::avgs::averages
; ::avgg::averaging
; ::ay::away
; ::ayfr::away from
; ::ayfre::away from the
; ::bq::back
; ::bg/::background
; ::bblt::be able to
; ::bzd::be used
; ::bca::became
; ::bc::because
; ::bcv::because of
; ::bce::because the
; ::bcm::become
; ::bcms::becomes
; ::bcmg::becoming
; ::bn::been
; ::bf::before
; ::bfkaf::before and after
; ::bfe::before the
; ::bga::began
; ::bgi::begin
; ::bgig::beginning
; ::bgis::begins
; ::bgu::begun
; ::bd::behind
; ::bde::behind the
; ::bg::being
; ::bgs::beings
; ::blv::believe
; ::blvd::believed
; ::blvs::believes
; ::blvg::believing
; ::bl::below
; ::bnx::beneath
; ::bnxe::beneath the
; ::bsd::beside
; ::bsds::besides
; ::bs::best
; ::btr::better
; ::bt::between
; ::btec::between each
; ::bte::between the
; ::btt::between the
; ::btxz::between these
; ::byd::beyond
; ::blq::black
; ::bl/::block list
; ::bls/::block lists
; ::bs/::blur spot
; ::bss/::blur spots
; ::bk::book
; ::bkd::booked
; ::bkg::booking
; ::bks::books
; ::bx::both
; ::bxv::both of
; ::bxve::both of the
; ::bxe::both the
; ::bm::bottom
; ::bmv::bottom of
; ::bmve::bottom of the
; ::bms::bottoms
; ::bfr::buffer
; ::bfrd::buffered
; ::bfrg::buffering
; ::bfrs::buffers
; ::bz::business
; ::bzs::businesses
; ::b::but
; ::bls::but also
; ::br/::but are
; ::bsq::but is not
; ::be/::but the
; ::bp::but was
; ::btn::button
; ::btnd::buttoned
; ::btng::buttoning
; ::btns::buttons
; ::ytt::by that
; ::ye::by the
; ::btw::by the way
; ::ywc::by which
; ::qq::calculate
; ::qqd::calculated
; ::qqs::calculates
; ::qqg::calculating
; ::qqj::calculation
; ::qqjs::calculations
; ::qqr::calculator
; ::qqrs::calculators
; ::ql::call
; ::qle::call the
; ::cf/::callback function
; ::cfs/::callback functions
; ::qld::called
; ::qlde::called the
; ::qlr::caller
; ::qlg::calling
; ::qls::calls
; ::qlse::calls the
; ::ca::came
; ::c::can
; ::clsb::can also be
; ::cb::can be
; ::cbzd::can be used
; ::cnb::can now be
; ::cnl::can only
; ::cnlb::can only be
; ::cstlb::can still be
; ::cq::cannot
; ::cqb::cannot be
; ::c'::can't
; ::cb'::can't be
; ::cz::cause
; ::qs::cause
; ::czd::caused
; ::qsd::caused
; ::czs::causes
; ::qss::causes
; ::czg::causing
; ::qsg::causing
; ::cg::change
; ::cge::change the
; ::cgd::changed
; ::cgs::changes
; ::cgg::changing
; ::ckr::character
; ::ckrk::characteristic
; ::ckrks::characteristics
; ::ckz::characterize
; ::ckzd::characterized
; ::ckzs::characterizes
; ::ckzg::characterizing
; ::ckrs::characters
; ::ck::check
; ::cktt::check that
; ::cke::check the
; ::ckd::checked
; ::ckg::checking
; ::cks::checks
; ::cs::class
; ::css::classes
; ::cll::clearly
; :*:cbd::Clipboard
; ::qo::close
; ::qod::closed
; ::qos::closes
; ::qog::closing
; ::csp/::cloud service provider
; ::clk::collect
; ::clkd::collected
; ::clkg::collecting
; ::clkj::collection
; ::clks::collects
; ::cllg::college
; ::cljs::colleges
; ::cljt::collegiate
; ::cm::come
; ::cms::comes
; ::cmg::coming
; ::cmd::command
; ::cmdd::commanded
; ::cmdg::commanding
; ::cmds::commands
; ::cmm::communicate
; ::cmmd::communicated
; ::cmms::communicates
; ::cmmg::communicating
; ::cmmj::communication
; ::cmmjs::communications
; ::cmj::communication
; ::cmjs::communications
; ::cmtys::communities
; ::cmty::community
; ::cos::companies
; ::co::company
; ::co'::company's
; ::kpr::compare
; ::kprd::compared
; ::kprs::compares
; ::kprg::comparing
; ::kex::comparison example
; ::kexs::comparison examples
; ::cp::complete
; ::cpd::completed
; ::cpl::completely
; ::cps::completes
; ::cpg::completing
; ::cpj::completion
; ::cpjs::completions
; ::cmp::computer
; ::cmps::computers
; ::cdj::condition
; ::cdjl::conditional
; ::cdjd::conditioned
; ::cdjg::conditioning
; ::cdjs::conditions
; ::cfj::configuration
; ::cfjs::configurations
; ::cf::configure
; ::cfd::configured
; ::cfs::configures
; ::cfg::configuring
; ::cfm::confirm
; ::cfmtt::confirm that
; ::cfmj::confirmation
; ::cfmd::confirmed
; ::cfmg::confirming
; ::cfms::confirms
; ::cc::connect
; ::cct::connect to
; ::ccte::connect to the
; ::ccd::connected
; ::ccdt::connected to
; ::ccdta::connected to a
; ::ccdte::connected to the
; ::ccdtog::connected together
; ::ccg::connecting
; ::ccj::connection
; ::ccjs::connections
; ::ccvt::connectivity
; ::ccr::connector
; ::ccrs::connectors
; ::ccs::connects
; ::csr::consider
; ::csrt::considerate
; ::csrtl::considerately
; ::csrj::consideration
; ::csrd::considered
; ::csrg::considering
; ::csrs::considers
; ::kk::contact
; ::kkd::contacted
; ::kkg::contacting
; ::kks::contacts
; ::cn::contain
; ::cnd::contained
; ::cnr::container
; ::cnrs::containers
; ::cng::containing
; ::cns::contains
; ::ctnl::continually
; ::ctnj::continuation
; ::ctn::continue
; ::ctnd::continued
; ::ctns::continues
; ::ctng::continuing
; ::ctnu::continuous
; ::ctnul::continuously
; ::knl::control
; ::knld::controlled
; ::knlr::controller
; ::knlrs::controllers
; ::knlg::controlling
; ::knls::controls
; ::cvl::conventional
; ::cvj::conversion
; ::cvjs::conversions
; ::cv::convert
; ::cvd::converted
; ::cvr::converter
; ::cvrs::converters
; ::cvg::converting
; ::cvs::converts
; ::cyd::copied
; ::ckpd::copied and pasted
; ::cys::copies
; ::ckps::copies and pastes
; ::cy::copy
; ::ckp::copy and paste
; ::cyg::copying
; ::ckpg::copying and pasting
; ::ct::correct
; ::ctd::corrected
; ::ctg::correcting
; ::ctj::correction
; ::ctl::correctly
; ::cts::corrects
; ::crr::correspond
; ::crrte::correspond to the
; ::crrd::corresponded
; ::crrc::correspondence
; ::crrg::corresponding
; ::crrt::corresponding to
; ::crrtt::corresponding to that
; ::crrgte::corresponding to the
; ::crrs::corresponds
; ::crrst::corresponds to
; ::crrste::corresponds to the
; ::qd::could
; ::qdb::could be
; ::qdv::could have
; ::qdvbn::could have been
; ::qdq::could not
; ::qdqb::could not be
; ::qd'::couldn't
; ::qdv'::could've 
; ::ctys::countries
; ::cty::country
; ::crss::courses
; ::cr::create
; ::cre::create the
; ::crd::created
; ::crs::creates
; ::crg::creating
; ::crj::creation
; ::crjs::creations
; ::crr::creator
; ::crrs::creators
; ::cu::current
; ::cul::currently
; ::cus::currents
; ::da::data
; ::dast::data store
; ::dasts::data stores
; ::dab::database
; ::dabs::databases
; ::doh/::day of hospitalization
; ::dk::decrease
; ::dkd::decreased
; ::dks::decreases
; ::dkg::decreasing
; ::dfn::define
; ::dfnd::defined
; ::dfns::defines
; ::dfng::defining
; ::dfnj::definition
; ::dof::degree of freedom
; ::dsof::degrees of freedom
; ::delb::deletable
; ::del::delete
; ::deld::deleted
; ::dels::deletes
; ::delg::deleting
; ::delj::deletion
; ; ::dms::demonstrate
; ; ::dmsd::demonstrated
; ; ::dmss::demonstrates
; ; ::dmsg::demonstrating
; ::dpn::depend,
; ::dpnd::depended
; ::dpng::depending
; ::dpns::depends
; ::de::describe
; ::ded::described
; ::dedbv::described above
; ::dedbl::described below
; ::des::describes
; ::deg::describing
; ::dej::description
; ::dejs::descriptions
; ::dtk::detect
; ::dtkd::detected
; ::dtkg::detecting
; ::dtkj::detection
; ::dtks::detects
; ::dmj::determination
; ::dmjs::determinations
; ::dm::determine
; ::dmd::determined
; ::dms::determines
; ::dmg::determining
; ::dv::develop
; ::dvd::developed
; ::dvr::developer
; ::dvrs::developers
; ::dvg::developing
; ::dvm::development
; ::dvml::developmental
; ::dvms::developments
; ::dvs::develops
; ::dvc::device
; ::dvcs::devices
; ::ddq::did not
; ::dd'::didn't
; ::dfc::difference
; ::dfcs::differences
; ::df::different
; ::dfta::different than
; ::dftai::different than in
; ::dftai::different than in the
; ::dfta::different than the
; ::dfl::differently
; ::dfk::difficult
; ::dfks::difficulties
; ::dfkt::difficulty
; ::dr::direct
; ::drd::directed
; ::drg::directing
; ::drj::direction
; ::drjl::directional
; ::drjlt::directionality
; ::drjs::directions
; ::drl::directly
; ::dys::directories
; ::dy::directory
; ::drs::directs
; ::db::disable
; ::dbd::disabled
; ::dbs::disables
; ::dbg::disabling
; ::dcc::disconnect
; ::dccd::disconnected
; ::dccg::disconnecting
; ::dccj::disconnection
; ::dccs::disconnects
; ::dctnj::discontinuation
; ::dctn::discontinue
; ::dctnd::discontinued
; ::dctns::discontinues
; ::dctng::discontinuing
; ::dp::display
; ::dpd::displayed
; ::dpg::displaying
; ::dps::displays
; ::dbt::distribute
; ::dbtd::distributed
; ::dbts::distributes
; ::dbtg::distributing
; ::dbtj::distribution
; ::dq::do not
; ::dqy::do not yet
; ::dc::document
; ::dcj::documentation
; ::dcd::documented
; ::dcg::documenting
; ::dcs::documents
; ::ds::does
; ::dsq::does not
; ::dsqv::does not have
; ::dsqve::does not have the
; ::ds'::doesn't
; ::dg::doing
; ::d'::don't
; ::db'::don't be
; ::dn::down
; ::dne::down the
; ::dnd::downed
; ::dl::download
; ::dld::downloaded
; ::dlg::downloading
; ::dls::downloads
; ::dnrt::downright
; ::dt::due to
; ::dte::due to the
; ::dtts::due to this
; ::dng::during
; ::dnge::during the
; ::ec::each
; ::ecv::each of
; ::ecve::each of the
; ::ecvxz::each of these
; ::ecot::each other
; ::ecti::each time
; ::eyr::earlier
; ::ezr::easier
; ::ezt::easiest
; ::ezl::easily
; ::ez::easy
; ::dkt::educate
; ::dktd::educated
; ::dkts::educates
; ::dktg::educating
; ::dktj::educational
; ::efk::effect
; ::efkd::effected
; ::efkg::effecting
; ::efkv::effective
; ::efkvl::effectively
; ::efkvn::effectiveness
; ::efks::effects
; ::exr::either
; ::exrz::either as
; ::lel::electrical
; ::lell::electrically
; ::lwh::elsewhere
; ::eml::email
; ::emld::emailed
; ::emlg::emailing
; ::emls::emails
; ::em::embodiment
; ::empe::embodiment of the present invention
; ::empi::embodiment of the present invention
; ::ems::embodiments
; ::emspe::embodiments of the present invention
; ::emspi::embodiments of the present invention
; ::eb::enable
; ::ebdb::enable/disable
; ::ebd::enabled
; ::ebddbd::enabled/disabled
; ::ebdbd::enabled/disabled
; ::ebs::enables
; ::ebsdbs::enables/disables
; ::ebg::enabling
; ::ebgdbg::enabling/disabling
; ::en::English
; ::nf::enough
; ::eju::ensure
; ::ejud::ensured
; ::ejus::ensures
; ::ejug::ensuring
; ::ntr::entire
; ::ntrl::entirely
; ::ntrt::entirety
; ::enm::enumerate
; ::enmd::enumerated
; ::enmtp::enumerated type
; ::enms::enumerates
; ::enmg::enumerating
; ::enmj::enumeration
; ::enmjs::enumerations
; ::env::environment
; ::envl::environmental
; ::envs::environments
; ::q/::equal to
; ::edez::ErgoDox EZ
; ::rrz::erroneous
; ::rrzl::erroneously
; ::rr::error
; ::rrs::errors
; ::esl::especially
; ::evl::evaluate
; ::evld::evaluated
; ::evls::evaluates
; ::evlg::evaluating
; ::evlj::evaluation
; ::evljs::evaluations
; ::vn::even
; ::vnl::even if
; ::vnle::even if the
; ::vnlu::even if you
; ::vni::even in
; ::vne::even the
; ::vnxo::even though
; ::vnxoe::even though the
; ::vnwn::even when
; ::vnwne::even when the
; ::vnu::eventual
; ::vnul::eventually
; ::er::ever
; ::ey::every
; ::eyd::every day
; ::eyot::every other
; ::eyb::everybody
; ::eyn::everyone
; ::eyn'::everyone's
; ::eytg::everything
; ::eytgl::everything else
; ::eywh::everywhere
; ::ek::exact
; ::ekd::exacted
; ::ekg::exacting
; ::ekl::exactly
; ::eks::exacts
; ::ex::example
; ::exs::examples
; ::ept::except
; ::eptf::except for
; ::eptfe::except for the
; ::eptitt::except in that
; ::eptj::exception
; ::ecg::exchange
; ::ecgd::exchanged
; ::ecgs::exchanges
; ::ecgg::exchanging
; ::ecl::exclude
; ::ecld::excluded
; ::ecls::excludes
; ::eclg::excluding
; ::eclj::exclusion
; ::ecljs::exclusions
; ::ekv::exclusive
; ::ekvl::exclusively
; ::eqb::executable
; ::eqbs::executables
; ::eq::execute
; ::eqd::executed
; ::eqs::executes
; ::eqg::executing
; ::eqj::execution
; ::eht::exhibit
; ::ehtd::exhibited
; ::ehtg::exhibiting
; ::ehtj::exhibition
; ::ehtjs::exhibitions
; ::ehts::exhibits
; ::ej::exist
; ::ejd::existed
; ::ejc::existence
; ::ejl::existential
; ::ejg::existing
; ::ejs::exists
; ::epk::expect
; ::epkj::expectation
; ::epkjs::expectations
; ::epkd::expected
; ::epkg::expecting
; ::epks::expects
; ::ep::experience
; ::epd::experienced
; ::eps::experiences
; ::epg::experiencing
; ::epl::explain
; ::epld::explained
; ::eplg::explaining
; ::epls::explains
; ::eplj::explanation
; ::et::extend
; ::etd::extended
; ::etg::extending
; ::ets::extends
; ::etj::extension
; ::etjs::extensions
; ::fams::families
; ::fam::family
; ::fxr::father
; ::fxrd::fathered
; ::fxrg::fathering
; ::fxrs::fathers
; ::fc::feature
; ::fcd::featured
; ::fcs::features
; ::fcg::featuring
; ::fdbq::feedback
; ::fg::figure
; ::fgd::figured
; ::fgs::figures
; ::fgg::figuring
; ::fi::file
; ::fid::filed
; ::finm::filename
; ::finms::filenames
; ::fis::files
; ::fi'::file's
; ::fzj::finalization
; ::fz::finalize
; ::fzd::finalized
; ::fzs::finalizes
; ::fzg::finalizing
; ::fny::finally
; ::fy::finally
; ::fd::find
; ::fdg::finding
; ::fw/::firewall
; ::fws/::firewalls
; ::fw::firmware
; ::ft::first
; ::xd::third
; ::ftksk::first and second
; ::ftsk::first and second
; ::fttg::first thing
; ::ftti::first time
; ::ftg::fix together
; ::fab::fixed a bug
; ::fabw::fixed a bug where
; ::fdtg::fixed together
; ::fstg::fixes together
; ::fgtg::fixing together
; ::flh::flight
; ::flhs::flights
; ::fl::follow
; ::fld::followed
; ::flr::follower
; ::flrs::followers
; ::flg::following
; ::fls::follows
; ::f::for
; ::flve::for all of the
; ::fec::for each
; ::fecve::for each of the
; ::fex::for example
; ::fmrmj::for more information
; ::fsmrz::for some reason
; ::fju::for sure
; ::ftt::for that
; ::fe::for the
; ::fxz::for these
; ::fts::for this
; ::fwc::for which
; ::fwce::for which the
; ::fg/::foreground
; ::fer::forever
; ::frg::forget
; ::fm::form
; ::fme::form the
; ::fmj::formation
; ::fmd::formed
; ::fmdie::formed in the
; ::fmdne::formed on the
; ::fmr::former
; ::fmg::forming
; ::fms::forms
; ::frw::forward
; ::frwd::forwarded
; ::frwg::forwarding
; ::frws::forwards
; ::fdd::found
; ::fddtt::found that
; ::frd::friend
; ::frdl::friendly
; ::frds::friends
; ::fr::from
; ::frtt::from that
; ::fre::from the
; ::frts::from this
; ::frwc::from which
; ::fn::function
; ::fnx::function as
; ::fnrf::function reference
; ::fnrfs::function references
; ::fnl::functional
; ::fnlts::functionalities
; ::fnt::functionality
; ::fnll::functionally
; ::fnd::functioned
; ::fng::functioning
; ::fngx::functioning as
; ::fns::functions
; ::fnsx::functions as
; ::fnsxe::functions as the
; ::fx::further
; ::fxcl::further include
; ::fxcld::further included
; ::fxcls::further includes
; ::fxclg::further including
; ::fxta::further than
; ::fxd::furthered
; ::fxg::furthering
; ::fxm::furthermore
; ::fxs::furthers
; ::fxt::furthest
; ::fut::future
; ::gm::game
; ::gmsr::game server
; ::gmsrs::game servers
; ::gmd::gamed
; ::gmpy::gameplay
; ::gmr::gamer
; ::gmrs::gamers
; ::gms::games
; ::gmg::gaming
; ::ga::gave
; ::gnl::general
; ::gnll::generally
; ::gn::generate
; ::gnd::generated
; ::gns::generates
; ::gng::generating
; ::gnj::generation
; ::gnjs::generations
; ::gnr::generator
; ::gnrs::generators
; ::g::get
; ::ge::get the
; ::gs::gets
; ::gse::gets the
; ::gtg::getting
; ::gtge::getting the
; ::gl::girl
; ::gls::girls
; ::gv::give
; ::gvn::given
; ::gvny::given by
; ::gvni::given in
; ::gvntt::given that
; ::gvnti::given time
; ::gvs::gives
; ::gvg::giving
; ::gxr::go through
; ::gxre::go through the
; ::gsxr::goes through
; ::gsxre::goes through the
; ::gg::going
; ::ggfr::going from
; ::ggfre::going from the
; ::ggxr::going through
; ::ggxre::going through the
; ::gd::good
; ::gdn::goodness
; ::gds::goods
; ::gd'::good's
; ::gvm::government
; ::gr::great
; ::grr::greater
; ::grta::greater than
; ::grtae::greater than the
; ::grrta::greater than
; ::get/::greater than or equal to
; ::grrtae::greater than the
; ::grt::greatest
; ::grl::greatly
; ::gp::group
; ::gpv::group of
; ::gpd::grouped
; ::gpg::grouping
; ::gps::groups
; ::gw::grow
; ::dbn::had been
; ::dqbn::had not been
; ::dq'::hadn't
; ::hp::happen
; ::hpd::happened
; ::hpg::happening
; ::hps::happens
; ::hw::hardware
; ::hlsbn::has also been
; ::hbn::has been
; ::hq::has not
; ::hqbn::has not been
; ::hqy::has not yet
; ::hs'::hasn't
; ::v::have
; ::vlsbn::have also been
; ::vbn::have been
; ::vq::have not
; ::vqy::have not yet
; ::ve/::have the
; ::v2::have to
; ::v'::haven't
; ::vg::having
; ::hlx::health
; ::hlxy::healthy
; ::lp::help
; ::lpd::helped
; ::lpf::helpful
; ::lpg::helping
; ::lps::helps
; ::hr::here
; ::hr'::here's
; ::rsf::herself
; ::hh::high
; ::hhr::higher
; ::hhta::higher than
; ::hhta::higher than the
; ::hht::highest
; ::hhlh::highlight
; ::hhl::highly
; ::msf::himself
; ::htys::histories
; ::hty::history
; ::htyv::history of
; ::hm::home
; ::ho::hope
; ::h::how
; ::hs::how is
; ::hmn::how many
; ::hmc::how much
; ::he/::how the
; ::htz::how to use
; ::hv::however
; ::h'::how's
; ::hn::human
; ::hns::humans
; ::im::I am
; ::ic::I can
; ::ic'::I can't
; ::idq::I do not
; ::iv::I have
; ::ikw::I know
; ::ikwoim::I know who I am
; ::ixk::I think
; ::iwu::I want
; ::ip::I was
; ::il::I will
; ::id'::I'd
; ::ltz::if it is
; ::lpbl::if possible
; ::le::if the
; ::lts::if this
; ::lu::if you
; ::lur::if you are
; ::l'::I'll
; ::m'::I'm
; ::ig::image
; ::igd::imaged
; ::igs::images
; ::igg::imaging
; ::imm::immediate
; ::imml::immediately
; ::imp::implement
; ::impj::implementation
; ::impjs::implementations
; ::impd::implemented
; ::impg::implementing
; ::imps::implements
; ::mpc::importance
; ::mp::important
; ::mpl::importantly
; ::ipbl::impossible
; ::ioow::in accordance with
; ::ioowe::in accordance with the
; ::idj::in addition
; ::ibt::in between
; ::iof::in order for
; ::iofe::in order for the
; ::iot::in order to
; ::iotb::in order to be
; ::iow::in other words
; ::ismc::in some cases
; ::itv::in terms of
; ::itt::in that
; ::itte::in that the
; ::ie::in the
; ::ieeda::in the embodiment described above
; ::ieesda::in the embodiments described above
; ::iefut::in the future
; ::iepe::in the present embodiment
; ::iepi::in the present invention
; ::ixz::in these
; ::its::in this
; ::itc::in this case
; ::itm::in this manner
; ::itw::in this way
; ::iwc::in which
; ::iwce::in which the
; ::cl::include
; ::cle::include the
; ::cld::included
; ::cls::includes
; ::clse::includes the
; ::clg::including
; ::clj::inclusion
; ::icp::incomplete
; ::icpl::incompletely
; ::ict::incorrect
; ::ictl::incorrectly
; ::ik::increase
; ::icre::increase the
; ::ikdk::increase/decrease
; ::ikd::increased
; ::iks::increases
; ::ikg::increasing
; ::ikgdkg::increasing/decreasing
; ::ikl::increasingly
; ::isr::independent server
; ::isrs::independent servers
; ::idfc::indifference
; ::idf::indifferent
; ::idr::indirect
; ::idrl::indirectly
; ::mj::information
; ::mj::information
; ::is/::information security
; ::mjl::informational
; ::ij::initial
; ::ijvl::initial value
; ::ijd::initialed
; ::ijg::initialing
; ::izj::initialization
; ::iz::initialize
; ::izd::initialized
; ::izs::initializes
; ::izg::initializing
; ::ijl::initially
; ::ijs::initials
; ::np::input
; ::nps::inputs
; ::npg::inputting
; ::isd::inside
; ::isdv::inside of
; ::isdve::inside of the
; ::isde::inside the
; ::isc::instance
; ::iscve::instance of the
; ::iscs::instances
; ::id::instead
; ::idv::instead of
; ::idve::instead of the
; ::trst::interest
; ::trstd::interested
; ::trstg::interesting
; ::trsts::interests
; ::io::into
; ::ioe::into the
; ::ntts::into this
; ::iowc::into which
; ::iowce::into which the
; ::ivj::invention
; ::ivjs::inventions
; ::ivc::invoice
; ::ivcd::invoiced
; ::ivcs::invoices
; ::ivcg::invoicing
; ::irs/::IR sensor
; ::sajd::is arranged
; ::sqld::is called
; ::scpl::is complete
; ::sdpd::is displayed
; ::sfmd::is formed
; ::zt::is it
; ::smdfr::is made from
; ::sq::is not
; ::sqe::is not the
; ::sqy::is not yet
; ::sn/::is now
; ::stt::is that
; ::se::is the
; ::szdz::is used as
; ::szdxe::is used as the
; ::s'::isn't
; ::thbn::it has been
; ::tz::it is
; ::tzq::it is not
; ::tze::it is the
; ::ts'::it isn't
; ::tzms::it seems
; ::tzmslk::it seems like
; ::tp/::it was
; ::tp'::it wasn't
; ::twl::it will
; ::twlb::it will be
; :C:i::its
; ::i'::it's
; ::iab'::it's about
; ::iq'::it's not
; ::iqab'::it's not about
; ::itt'::it's that
; ::tsf::itself
; ::iv'::I've
; ::ja::Japanese
; ::jc/::JOY-CON
; ::j::just
; ::jlk::just like
; ::jlkts::just like this
; ::je::just the
; ::kp::keep
; ::kpe::keep the
; ::kpg::keeping
; ::kps::keeps
; ::kpd::kept
; ::kd::kind
; ::kdv::kind of
; ::kdl::kindly
; ::kds::kinds
; ::kdsv::kinds of
; ::kw::know
; ::kwg::knowing
; ::kptj::Knowledge. Peace. Trust. Journey
; ::kn::known
; ::kwn::known
; ::knx::known as
; ::kws::knows
::kx::kthxwtfbbq
; ::lng::language
; ::lngs::languages
; ::lg::large
; ::lgl::largely
; ::lgr::larger
; ::lgta::larger than
; ::lgtae::larger than the
; ::lgt::largest
; ::lt::last
; ::lr::later
; ::ltt::latter
; ::lc::launch
; :C:lcd::launched
; :C:Lcd::launched
; ::lcr::launcher
; ::lcrs::launchers
; ::lcs::launches
; ::lcg::launching
; ::lev::leave
; ::levs::leaves
; ::levg::leaving
; ::lsta::less than
; ::let/::less than or equal to
; ::lstae::less than the
; ::ltr::letter
; ::ltrd::lettered
; ::ltrg::lettering
; ::ltrs::letters
; ::lvl::level
; ::lvld::leveled
; ::lvlg::leveling
; ::lvls::levels
; ::lis::libraries
; ::li::library
; ::la/::library applet
; ::las/::library applets
; ::lf::life
; ::lfti::lifetime
; ::lftis::lifetimes
; ::lh::light
; ::lhr::lighter
; ::lhg::lighting
; ::lhl::lightly
; ::lhs::lights
; ::lk::like
; ::lki::like in
; ::lkie::like in the
; ::lktt::like that
; ::lke::like the
; ::lkts::like this
; ::lkd::liked
; ::lkl::likely
; ::lks::likes
; ::lkw::likewise
; ::lkg::liking
; ::ln::line
; ::lns::lines
; ::ll::little
; ::llb::little bit
; ::ld::load
; ::ldd::loaded
; ::ldg::loading
; ::lds::loads
; ::llss::local system
; ::lj::location
; ::ljs::locations
; ::lq::look
; ::lqlk::look like
; ::lqd::looked
; ::lqg::looking
; ::lqglk::looking like
; ::lqs::looks
; ::lqslk::looks like
; ::lsc::Love. Strength. Confidence
; ::md::made
; ::mdfr::made from
; ::mdpt::made it possible to
; ::mdv::made of
; ::mn::maintain
; ::mnd::maintained
; ::mng::maintaining
; ::mns::maintains
; ::mnc::maintenance
; ::mk::make
; ::mpf::make it possible for
; ::mpfe::make it possible for the
; ::mpt::make it possible to
; ::mkju::make sure
; ::mkjutt::make sure that
; ::mkjut::make sure to
; ::mke::make the
; ::mks::makes
; ::mspf::makes it possible for
; ::mspfe::makes it possible for the
; ::mspt::makes it possible to
; ::mkg::making
; ::mgpf::making it possible for
; ::mgpfe::making it possible for the
; ::mgpt::making it possible to
; ::mkgju::making sure
; ::mg::manage
; ::mgb::manageable
; ::mgd::managed
; ::mgm::management
; ::mgr::manager
; ::mgrs::managers
; ::mgs::manages
; ::mgg::managing
; ::ma::many
; ::mkt::market
; ::mktd::marketed
; ::mktg::marketing
; ::mkts::markets
; ::mmk::matchmake
; ::mmkg::matchmaking
; ::mmkgsj::matchmaking session
; ::mmsj::matchmaking session
; ::mmkgsjs::matchmaking sessions
; ::mmsjs::matchmaking sessions
; ::mrl::material
; ::mrls::materials
; ::mtt::matter
; ::mttd::mattered
; ::mtts::matters
; ::mxz::maximize
; ::mxzd::maximized
; ::mxzs::maximizes
; ::mxzg::maximizing
; ::mxm::maximum
; ::m::may
; ::mls::may also
; ::mlsb::may also be
; ::mlsbzd::may also be used
; ::mb::may be
; ::mbfmd::may be formed
; ::mbe::may be the
; ::mbzd::may be used
; ::mv/::may have
; ::mvbn::may have been
; ::mq::may not
; ::mqb::may not be
; ::yb::maybe
; ::mnhl::meanwhile
; ::mz::measure
; ::mzd::measured
; ::mzm::measurement
; ::mzms::measurements
; ::mzs::measures
; ::mzg::measuring
; ::mbr::member
; ::mbrs::members
; ::mem::memory
; ::msg::message
; ::msgd::messaged
; ::msgs::messages
; ::msgg::messaging
; ::mda::metadata
; ::mex::method
; ::mexs::methods
; ::mh::might
; ::mhb::might be
; ::mhvbn::might have been
; ::mll::million
; ::mlls::millions
; ::mnz::minimize
; ::mnzd::minimized
; ::mnzs::minimizes
; ::mnzg::minimizing
; ::mnm::minimum
; ::mnt::minute
; ::mnts::minutes
; ::mfj::modification
; ::mfd::modified
; ::mfs::modifies
; ::mf::modify
; ::mfg::modifying
; ::mm::moment
; ::mms::moments
; ::mny::money
; ::mx::month
; ::mxl::monthly
; ::mxs::months
; ::mr::more
; ::mrv::more of
; ::mrve::more of the
; ::mrta::more than
; ::mrtae::more than the
; ::mrov::moreover
; ::mrng::morning
; ::mo::most
; ::mov::most of
; ::mol::mostly
; ::mxr::mother
; ::mxrd::mothered
; ::mxrg::mothering
; ::mxrs::mothers
; ::mv::move
; ::mve::move the
; ::mvd::moved
; ::mvm::movement
; ::mvms::movements
; ::mvs::moves
; ::mvg::moving
; ::mc::much
; ::mcmr::much more
; ::ml::multiple
; ::mld::multiplied
; ::ms::must
; ::msls::must also
; ::mslsb::must also be
; ::msb::must be
; ::msq::must not
; ::ysf::myself
; ::nm::name
; ::nmv::name of
; ::nmve::name of the
; ::nmd::named
; ::nml::namely
; ::nms::names
; ::nmsv::names of
; ::nmsve::names of the
; ::nmsp::namespace
; ::nmsps::namespaces
; ::nmg::naming
; ::nj::nation
; ::njl::national
; ::njll::nationally
; ::njs::nations
; ::nr::near
; ::nre::near the
; ::nrt::nearest
; ::nrl::nearly
; ::nd::need
; ::ndt::need to
; ::ndtb::need to be
; ::ndd::needed
; ::nddtb::needed to be
; ::ndg::needing
; ::ndl::needless
; ::nds::needs
; ::ndstb::needs to be
; ::niv::negative
; ::nivl::negatively
; ::nxr::neither
; ::nwk::network
; ::nsaid::network service account ID
; ::nsaids::network service account IDs
; ::nwkd::networked
; ::nwkg::networking
; ::nwks::networks
; ::nv::never
; ::nx::next
; ::nxlvl::next level
; ::nxti::next time
; ::nxwq::next week
; ::nh::night
; ::nh::night
; ::nhl::nightly
; ::nhs::nights
; ::Nin::Nintendo
; ::nin'::Nintendo's
; ::nsdk::NintendoSDK
; ::nlg::no longer
; ::nlgb::no longer be
; ::nby::nobody
; ::nnve::none of the
; ::q::not
; ::qb::not be
; ::qj::not just
; ::qnl::not only
; ::qpbl::not possible
; ::qe::not the
; ::qy::not yet
; ::nttt::note that
; ::nttte::note that the
; ::ng::nothing
; ::nfyj::notification
; ::nfyd::notified
; ::nfys::notifies
; ::nfy::notify
; ::nfyg::notifying
; ::n::now
; ::nwh::nowhere
; ::nb::number
; ::nbv::number of
; ::nbd::numbered
; ::nbg::numbering
; ::nbs::numbers
; ::nbsv::numbers of
; ::oj::object
; ::ojd::objected
; ::ojg::objecting
; ::ojj::objection
; ::ojv::objective
; ::ojl::objectively
; ::ojvs::objectives
; ::ojs::objects
; ::oc::occur
; ::ocd::occurred
; ::occ::occurrence
; ::occs::occurrences
; ::ocg::occurring
; ::ocs::occurs
; ::vec::of each
; ::vecve::of each of the
; ::vots::of others
; ::vtt::of that
; ::ve::of the
; ::vepe::of the present embodiment
; ::vepi::of the present invention
; ::vxz::of these
; ::vts::of this
; ::vxs::of those
; ::vwc::of which
; ::vur::of your
; ::ffc::office
; ::ffcr::officer
; ::ffcs::offices
; ::ffcl::official
; ::ffcls::officials
; ::oft::often
; ::om::omit
; ::oms::omits
; ::omd::omitted
; ::omg::omitting
; ::oec::on each
; ::ott::on that
; ::ne::on the
; ::nxz::on these
; ::ntv::on top of
; ::ntve::on top of the
; ::nwc::on which
; ::nwce::on which the
; ::ws::once
; ::wse::once the
; ::nar::one another
; ::nar'::one another's
; ::1v::one of
; ::nvy::one of my
; ::nve::one of the
; ::nvxm::one of them
; ::nvxz::one of these
; ::nvxs::one of those
; ::nvwc::one of which
; ::1ft::One. Focus. Time
; ::nl::only
; ::nlb::only be
; ::nle::only the
; ::nt::onto
; ::nte::onto the
; ::ntwc::onto which
; ::op::open
; ::opb::openable
; ::opd::opened
; ::opg::opening
; ::opgs::openings
; ::ops::opens
; ::os/::operating system
; ::oss/::operating systems
; ::opj::operation
; ::opjs::operations
; ::pj::option
; ::pjs::options
; ::omr::or more
; ::oe::or the
; ::olk::or the like
; ::ot::other
; ::otta::other than
; ::ottae::other than the
; ::ots::others
; ::otw::otherwise
; ::osv::ourselves
; ::wp::output
; ::wpfr::output from
; ::wpfre::output from the
; ::wps::outputs
; ::wpg::outputting
; ::tsd::outside
; ::tsdv::outside of
; ::tsdve::outside of the
; ::ov::over
; ::ove::over the
; ::ovl::overall
; ::oa/::overlay applet
; ::oas/::overlay applets
; ::ovld::overload
; ::ovlds::overloads
; ::ovti::overtime
; ::pak::package
; ::pakd::packaged
; ::paks::packages
; ::pakg::packaging
; ::pg::page
; ::pgd::paged
; ::pgs::pages
; ::pgg::paging
; ::pwk::paperwork
; ::pgh::paragraph
; :O*:pgh/::paragraph []{Left}
; ::pghs::paragraphs
; :O*:pghs/::paragraphs [] to []{Left 7}
; ::pa::parameter
; ::pas::parameters
; ::prn::parent
; ::prnd::parented
; ::prng::parenting
; ::prns::parents
; ::pt::part
; ::ptv::part of
; ::ptve::part of the
; ::ptd::parted
; ::ptc::particle
; ::ptcs::particles
; ::plr::particular
; ::plrl::particularly
; ::ptg::parting
; ::ptl::partly
; ::pts::parts
; ::ptsv::parts of
; ::ptsve::parts of the
; ::pxr::pass through
; ::pdxr::passed through
; ::psxr::passes through
; ::pgxr::passing through
; ::pawd::password
; ::pawds::passwords
; ::pp::people
; ::pp'::people's
; ::pfk::perfect
; ::pfkd::perfected
; ::pfkg::perfecting
; ::pfkj::perfection
; ::pfkl::perfectly
; ::pfks::perfects
; ::pf::perform
; ::pfc::performance
; ::pfd::performed
; ::pfg::performing
; ::pfs::performs
; ::ph::perhaps
; ::pn::person
; ::pnl::personal
; ::pnlt::personality
; ::pnll::personally
; ::pnel::personnel
; ::pns::persons
; ::pn'::person's
; ::peds::Jak's ErgoDox Stenotype
; ::px::pixel
; ::pxs::pixels
; ::pl::place
; ::pld::placed
; ::plm::placement
; ::pls::places
; ::plg::placing
; ::py::play
; ::pybq::playback
; ::pyd::played
; ::pyr::player
; ::pyrs::players
; ::pyg::playing
; ::pys::plays
; ::pz::please
; ::plmkyt::please let me know your thoughts
; ::pzd::pleased
; ::plv::plurality of
; ::plcs::policies
; ::plc::policy
; ::pltcl::political
; ::pltcll::politically
; ::pltc::politics
; ::prj::portion
; ::prjv::portion of
; ::prjve::portion of the
; ::prjd::portioned
; ::prjg::portioning
; ::prjs::portions
; ::prjsv::portions of
; ::prjsve::portions of the
; ::pos::position
; ::posl::positional
; ::posd::positioned
; ::posg::positioning
; ::poss::positions
; ::piv::positive
; ::pivl::positively
; ::pbt::possibility
; ::pbl::possible
; ::pby::possibly
; ::prf::preference
; ::prfs::preferences
; ::prfj::preferential
; ::ps::prescribed
; ::pem::present embodiment
; ::pi::present invention
; ::pdt::president
; ::pdts::presidents
; ::pv::prevent
; ::pvd::prevented
; ::pvg::preventing
; ::pvj::prevention
; ::pvs::prevents
; ::pw::preview
; ::pwd::previewed
; ::pwg::previewing
; ::pws::previews
; ::prv::previous
; ::prvl::previously
; ::pid::principal ID
; ::pids::principal IDs
; ::prb::probably
; ::prbb::probably be
; ::prbq::probably not
; ::pb::problem
; ::pbm::problematic
; ::pbs::problems
; ::pc::proceed
; ::pcd::proceeded
; ::pcg::proceeding
; ::pcs::proceeds
; ::pr::process
; ::prd::processed
; ::prs::processes
; ::prg::processing
; ::prr::processor
; ::prrs::processors
; ::pu::produce
; ::pud::produced
; ::pus::produces
; ::pug::producing
; ::puj::production
; ::pm::program
; ::pmd::programmed
; ::pmr::programmer
; ::pmrs::programmers
; ::pmg::programming
; ::pms::programs
; ::pk::project
; ::pkd::projected
; ::pkg::projecting
; ::pkj::projection
; ::pkjs::projections
; ::pks::projects
; ::pd::provide
; ::pdd::provided
; ::pddy::provided by
; ::pdr::provider
; ::pdr'::provider’s
; ::pdrs::providers
; ::pds::provides
; ::pdg::providing
; ::pdj::provision
; ::pbq::public
; ::pbql::publicly
; ::qn::question
; ::qns::questions
; ::qk::quick
; ::qkr::quicker
; ::qkl::quickly
; ::rx::rather
; ::rxta::rather than
; ::rxtae::rather than the
; ::rc::reach
; ::rcd::reached
; ::rcs::reaches
; ::rcg::reaching
; ::rd::read
; ::rdfr::read from
; ::rdfre::read from the
; ::rdb::readable
; ::rdg::reading
; ::rds::reads
; ::rdy::ready
; ::ry::really
; ::rz::reason
; ::rzb::reasonable
; ::rzbl::reasonably
; ::rzd::reasoned
; ::rzg::reasoning
; ::rzs::reasons
; ::rv::receive
; ::rvd::received
; ::rvr::receiver
; ::rvrs::receivers
; ::rvs::receives
; ::rvg::receiving
; ::ren::recent
; ::renl::recently
; ::rdr::redirect
; ::rdrd::redirected
; ::rdrg::redirecting
; ::rdrs::redirects
; ::ru::reduce
; ::rud::reduced
; ::rus::reduces
; ::rug::reducing
; ::ruj::reduction
; ::rujs::reductions
; ::rf::reference
; ::rfd::referenced
; ::rfs::references
; ::rfg::referencing
; ::rgl::regardless
; ::rgn::regenerate
; ::rgnd::regenerated
; ::rgns::regenerates
; ::rgng::regenerating
; ::rgnj::regeneration
; ::rg::region
; ::rgs::regions
; ::rgj::register
; ::rgjd::registered
; ::rgjg::registering
; ::rgjs::registers
; ::rgjj::registration
; ::rgjjs::registrations
; ::rl::release
; ::rld::released
; ::rls::releases
; ::rlg::releasing
; ::rmn::remain
; ::rmnd::remained
; ::rmng::remaining
; ::rmns::remains
; ::rmm::remember
; ::rmmd::remembered
; ::rmmg::remembering
; ::rmms::remembers
; ::rmb::removable
; ::rml::removal
; ::rm::remove
; ::rme::remove the
; ::rmd::removed
; ::rms::removes
; ::rmg::removing
; ::rnm::rename
; ::rnmd::renamed
; ::rnms::renames
; ::rnmg::renaming
; ::rt::repeat
; ::rtd::repeated
; ::rtl::repeatedly
; ::rtdl::repeatedly
; ::rtg::repeating
; ::rts::repeats
; ::rtv::repetitive
; ::rp::replace
; ::rpd::replaced
; ::rpm::replacement
; ::rpms::replacements
; ::rps::replaces
; ::rpg::replacing
; ::rep::represent
; ::repj::representation
; ::repjs::representations
; ::repv::representative
; ::repvs::representatives
; ::repd::represented
; ::repg::representing
; ::reps::represents
; ::qr::require
; ::qrd::required
; ::qrdy::required by
; ::qrdye::required by the
; ::qrm::requirement
; ::qrms::requirements
; ::qrs::requires
; ::qrg::requiring
; ::rsc::research
; ::rscd::researched
; ::rscs::researches
; ::rscg::researching
; ::rsj::reservation
; ::rsjs::reservations
; ::rsv::reserve
; ::rsvd::reserved
; ::rsvs::reserves
; ::rsvg::reserving
; ::riv::respective
; ::rivl::respectively
; ::rj::restart
; ::rje::restart the
; ::rjd::restarted
; ::rjg::restarting
; ::rjs::restarts
; ::rjse::restarts the
; ::rk::restrict
; ::rkd::restricted
; ::rkg::restricting
; ::rkj::restriction
; ::rkjs::restrictions
; ::rks::restricts
; ::rs::result
; ::rsi::result in
; ::rsd::resulted
; ::rsg::resulting
; ::rss::results
; ::rssi::results in
; ::rn::return
; ::rnvl::return value
; ::rnvls::return values
; ::rnd::returned
; ::rndye::returned by the
; ::rng::returning
; ::rns::returns
; ::rw::review
; ::rwd::reviewed
; ::rwg::reviewing
; ::rws::reviews
; ::rwt::rewrite
; ::rh::right
; ::rhay::right away
; ::rhn::right now
; ::sa::same
; ::sax::same as
; ::saxe::same as the
; ::sati::same time
; ::safd::satisfied
; ::safs::satisfies
; ::saf::satisfy
; ::safg::satisfying
; ::sv::save
; ::svda::save data
; ::sve::save the
; ::svd::saved
; ::svdz::saved as
; ::svd2::saved to
; ::svd2e::saved to the
; ::svs::saves
; ::svg::saving
; ::svgs::savings
; ::sy::say
; ::syg::saying
; ; ::sys::says
; ::scl::school
; ::scls::schools
; ::sdc::SD card
; ::sdcs::SD cards
; ::src::search
; ::srcf::search for
; ::srcd::searched
; ::srcdf::searched for
; ::srcs::searches
; ::srcsf::searches for
; ::srcg::searching
; ::srcgf::searching for
; ::sk::second
; ::sks::seconds
; ::skj::section
; ::skjd::sectioned
; ::skjg::sectioning
; ::skjs::sections
; ::zm::seem
; ::zmtb::seem to be
; ::zmd::seemed
; ::zms::seems
; ::zmslk::seems like
; ::zmstb::seems to be
; ::sl::select
; ::slb::selectable
; ::sld::selected
; ::slg::selecting
; ::slj::selection
; ::sljs::selections
; ::slv::selective
; ::sll::selectively
; ::slvl::selectively
; ::sls::selects
; ::skd::semiconductor
; ::skdrg::semiconductor region
; ::sr/::semiconductor region
; ::skdrgs::semiconductor regions
; ::skds::semiconductors
; ::stc::sentence
; ::stcs::sentences
; ::sep::separate
; ::sepd::separated
; ::sepl::separately
; ::seps::separates
; ::sepg::separating
; ::sepj::separation
; ::sepjs::separations
; ::sr::server
; ::srs::servers
; ::svc::service
; ::svcd::serviced
; ::svcs::services
; ::svcg::servicing
; ::sej::session
; ::sejs::sessions
; ::sg::setting
; ::sggtg::setting/getting
; ::sgs::settings
; ::svl::several
; ::sh::shall
; ::shb::shall be
; ::shq::shall not
; ::jd::should
; ::jdb::should be
; ::jdv::should have
; ::jdq::should not
; ::jd'::shouldn't
; ::jdv'::should've
; ::jw::show
; ::jwd::showed
; ::jwg::showing
; ::jwght::showing how to
; ::jn::shown
; ::jnbv::shown above
; ::jnbl::shown below
; ::jws::shows
; ::jwsh::shows how
; ::jwsht::shows how to
; ::jwse::shows the
; ::sd::side
; ::sdv::side of
; ::sdve::side of the
; ::sdd::sided
; ::sds::sides
; ::sdsv::sides of
; ::sdsve::sides of the
; ::sdg::siding
; ::sml::similar
; ::smlt::similar to
; ::smlte::similar to the
; ::smll::similarly
; ::sn::since
; ::sne::since the
; ::sng::single
; ::sz::size
; ::szve::size of the
; ::szd::sized
; ::szs::sizes
; ::szg::sizing
; ::slh::slight
; ::slhl::slightly
; ::jl::small
; ::jlr::smaller
; ::jlta::smaller than
; ::jltae::smaller than the
; ::jlt::smallest
; ::sjl::social
; ::sjlz::socialize
; ::sw::software
; ::soj::solution
; ::sojs::solutions
; ::sm::some
; ::smv::some of
; ::smve::some of the
; ::smvxz::some of these
; ::smb::somebody
; ::smh::somehow
; ::smn::someone
; ::smtg::something
; ::smt::sometime
; ::smts::sometimes
; ::smht::somewhat
; ::smwh::somewhere
; ::spl::special
; ::splj::specialization
; ::splzj::specialization
; ::splz::specialize
; ::splzd::specialized
; ::splzs::specializes
; ::splzg::specializing
; ::spk::specific
; ::spj::specification
; ::spjs::specifications
; ::spd::specified
; ::sps::specifies
; ::spse::specifies the
; ::sp::specify
; ::spe::specify the
; ::spg::specifying
; ::jt::start
; ::jte::start the
; ::jtd::started
; ::jtg::starting
; ::jts::starts
; ::jtp::startup
; ::st::state
; ::stve::state of the
; ::sttt::state that
; ::std::stated
; ::stm::statement
; ::stms::statements
; ::sts::states
; ::ststt::states that
; ::stg::stating
; ::stj::station
; ::stjd::stationed
; ::stjg::stationing
; ::stjs::stations
; ::stl::still
; ::stlb::still be
; ::jp::stop
; ::jpd::stopped
; ::jpg::stopping
; ::jps::stops
; ::jrj::storage
; ::su/::storage unit
; ::sus/::storage units
; ::jr::store
; ::jrd::stored
; ::jrs::stores
; ::jrg::storing
; ::jcrl::structurally
; ::jcr::structure
; ::jcrd::structured
; ::jcrs::structures
; ::jcrg::structuring
; ::sdn::student
; ::sdns::students
; ::sf::stuff
; ::sfd::stuffed
; ::sfg::stuffing
; ::sfs::stuffs
; ::sj::subject
; ::sjg::subject
; ::sjd::subjected
; ::sjs::subjects
; ::sbl::substantial
; ::sbll::substantially
; ::su::such
; ::sx::such as
; ::sxe::such as the
; ::sutt::such that
; ::sutte::such that the
; ::ggt::suggest
; ::ggtd::suggested
; ::ggtg::suggesting
; ::ggts::suggests
; ::ggtstt::suggests that
; ::sup::support
; ::supd::supported
; ::supg::supporting
; ::sups::supports
; ::ju::sure
; ::jul::surely
; ::sc::switch
; ::scd::switched
; ::scs::switches
; ::scg::switching
; ::ss::system
; ::sa/::system applet
; ::sas/::system applets
; ::ssda::system data
; ::ssud::system update
; ::ssuds::system updates
; ::ssk::systematic
; ::sskl::systematically
; ::sss::systems
; ::ss'::system's
; ::tk::take
; ::tkn::taken
; ::tknal::taken along
; ::tks::takes
; ::tkg::taking
; ::tcr::teacher
; ::tcrs::teachers
; ::tchs::technologies
; ::tch::technology
; ::tmp::temperature
; ::tmps::temperatures
; ::tpyl::temporarily
; ::tpy::temporary
; ::ta::than
; ::tai::than in
; ::taie::than in the
; ::tas::than is
; ::tatt::than that
; ::tae::than the
; ::tawn::than when
; ::xu::thank you
; ::xufym::thank you for your message
; ::xuvm::thank you very much
; ::xuvmfym::thank you very much for your message
; ::xvm::thank you very much for your message
; ::tt::that
; ::ttr::that are
; ::ttrq::that are not
; ::ttc::that can
; ::ttcb::that can be
; ::ttcqb::that cannot be
; ::ttdq::that do not
; ::ttdsq::that does not
; ::ttec::that each
; ::ttfnz::that function as
; ::ttfnsz::that functions as
; ::ttdbn::that had been
; ::tth::that has
; ::tthbn::that has been
; ::tthq::that has not
; ::tthqy::that has not yet
; ::ttv::that have
; ::ttvbn::that have been
; ::ttcl::that include
; ::ttcls::that includes
; ::ttclse::that includes the
; ::tts::that is
; ::ttsq::that is not
; ::tttz::that it is
; ::ttmu::that much
; ::ttmsb::that must be
; ::ttve::that of the
; ::ttjdb::that should be
; ::tttt::that that
; ::tte::that the
; ::ttts::that this
; ::ttz::that use
; ::ttp::that was
; ::ttpq::that was not
; ::ttwr::that were
; ::ttwrq::that were not
; ::ttwl::that will
; ::ttwlb::that will be
; ::ttwlq::that will not
; ::tt'::that's
; ::e::the
; ::epe::the present embodiment
; ::epi::the present invention
; ::esa::the same
; ::esax::the same as
; ::esaxe::the same as the
; ::th::their
; ::xm::them
; ::xm'::them's
; ::xmsf::themselves
; ::tn::then
; ::tne::then the
; ::tr::there
; ::trr::there are
; ::trrls::there are also
; ::trv::there have
; ::trvbn::there have been
; ::trs::there is
; ::trp::there was
; ::trwr::there were
; ::trwlb::there will be
; ::xbnx::therebeneath
; ::xbt::therebetween
; ::xb::thereby
; ::xbmpt::thereby making it possible to
; ::xf::therefore
; ::xfr::therefrom
; ::xi::therein
; ::xisd::thereinside
; ::xv::thereof
; ::tr'::there's
; ::xxr::therethrough
; ::xt::thereto
; ::xw::therewith
; ::xwi::therewithin
; ::xz::these
; ::xzr::these are
; ::ty::they
; ::tyr::they are
; ::tywr::they were
; ::tyd'::they'd
; ::ty'::they're
; ::tyv'::they've
; ::tg::thing
; ::tgs::things
; ::xk::think
; ::xkg::thinking
; ::xks::thinks
; ::ts::this
; ::tss::this is
; ::tsmrng::this morning
; ::tsskj::this section
; ::xh::thorough
; ::xhl::thoroughly
; ::xs::those
; ::xo::though
; ::tht::thought
; ::thtv::thought of
; ::thtf::thoughtful
; ::thts::thoughts
; ::xr::through
; ::xrtt::through that
; ::xre::through the
; ::xrwc::through which
; ::xrt::throughout
; ::xrte::throughout the
; ::ti::time
; ::tid::timed
; ::tir::timer
; ::tirs::timers
; ::tis::times
; ::tig::timing
; ::tb::to be
; ::2sv::to save
; ::2sup::to support
; ::te::to the
; ::tenxlvl::to the next level
; ::txz::to these
; ::2ts::to this
; ::twc::to which
; ::twce::to which the
; ::twct::to which to
; ::tfr/::to/from
; ::td::today
; ::td'::today's
; ::tog::together
; ::togw::together with
; ::togwe::together with the
; ::tmr::tomorrow
; ::tnh::tonight
; ::tmu::too much
; ::tc::touch
; ::tcd::touched
; ::tcs::touches
; ::tcg::touching
; ::tw::toward
; ::tws::towards
; ::twse::towards the
; ::tx::track
; ::txd::tracked
; ::txg::tracking
; ::txs::tracks
; ::tf::transfer
; ::tfd::transferred
; ::tfg::transferring
; ::tfs::transfers
; ::trj::transition
; ::trjl::transitional
; ::trjd::transitioned
; ::trjg::transitioning
; ::trjs::transitions
; ::trl::translate
; ::trld::translated
; ::trls::translates
; ::trlg::translating
; ::trlj::translation
; ::trljs::translations
; ::trlr::translator
; ::trlrs::translators
; ::tp::type
; ::tpv::type of
; ::tpd::typed
; ::tps::types
; ::tpsv::types of
; ::tq::typical
; ::tql::typically
; ::tpg::typing
; ::ub::unable
; ::uvlbl::unavailable
; ::ucgd::unchanged
; ::un::under
; ::une::under the
; ::utd::understand
; ::utdg::understanding
; ::utds::understands
; ::utdd::understood
; ::uepk::unexpected
; ::uepkl::unexpectedly
; ::ump::unimportant
; ::uizj::uninitialization
; ::uiz::uninitialize
; ::uizd::uninitialized
; ::uizs::uninitializes
; ::uizg::uninitializing
; ::uq::unique
; ::uql::uniquely
; ::nls::unless
; ::ulk::unlike
; ::ulkl::unlikely
; ::nld::unload
; ::nldd::unloaded
; ::nldg::unloading
; ::nlds::unloads
; ::umgb::unmanageable
; ::umgd::unmanaged
; ::urzb::unreasonable
; ::urzbl::unreasonably
; ::uspd::unspecified
; ::usupd::unsupported
; ::tl::until
; ::tle::until the
; ::ud::update
; ::udd::updated
; ::uds::updates
; ::udg::updating
; ::ug::upgrade
; ::ugd::upgraded
; ::ugs::upgrades
; ::ugg::upgrading
; ::ul::upload
; ::uld::uploaded
; ::ulg::uploading
; ::uls::uploads
; ::zbt::usability
; ::zb::usable
; ::zj::usage
; ::z::use
; ::ze::use the
; ::zts::use this
; ::zd::used
; ::zdx::used as
; ::zdxe::used as the
; ::zdf::used for
; ::zdfe::used for the
; ::zde::used the
; ::zdt::used to
; ::zfl::useful
; ::zls::useless
; ::zr::user
; ::zrda::user data
; ::zrnm::username
; ::zrnms::usernames
; ::zrs::users
; ::zr'::user's
; ::zr'::user's
; ::zs::uses
; ::zse::uses the
; ::zg::using
; ::zge::using the
; ::zgts::using this
; ::zl::usual
; ::zll::usually
; ::vlb::valuable
; ::vl::value
; ::vlv::value of
; ::vlve::value of the
; ::vld::valued
; ::vls::values
; ::vlg::valuing
; ::var::variable
; ::vars::variables
; ::vrt::variety
; ::vr::various
; ::vj::version
; ::vjv::version of
; ::vjve::version of the
; ::vjg::versioning
; ::vjs::versions
; ::vjsv::versions of
; ::vjsve::versions of the
; ::vy::very
; ::vymu::very much
; ::vyel::very well
; ::vw::view
; ::vwd::viewed
; ::vwr::viewer
; ::vwrs::viewers
; ::vwg::viewing
; ::vws::views
; ::wu::want
; ::wud::wanted
; ::wug::wanting
; ::wus::wants
; ::p::was
; ::pq::was not
; ::pe::was the
; ::wa/::Washington
; ::p'::wasn't
; ::wq::week
; ::wqd::weekend
; ::wqs::weeks
; ::el::well
; ::wr::were
; ::wer'::we're
; ::wrq::were not
; ::wr'::weren't
; ::wev'::we've
; ::ht::what
; ::htimdgwylf::what I am doing with my life
; ::hts::what is
; ::hte::what the
; ::hter::whatever
; ::htq::whatnot
; ::ht'::what's
; ::htser::whatsoever
; ::wn::when
; ::wnie::when in the
; ::wne::when the
; ::wnzg::when using
; ::wner::whenever
; ::wh::where
; ::whimgg::where I am going
; ::whe::where the
; ::whz::whereas
; ::whi::wherein
; ::whie::wherein the
; ::wher::wherever
; ::htr::whether
; ::htre::whether the
; ::htrt::whether to
; ::wc::which
; ::wcr::which are
; ::wccb::which can be
; ::wch::which has
; ::wcv::which have
; ::wcs::which is
; ::wce::which the
; ::wcp::which was
; ::wcwr::which were
; ::wcwl::which will
; ::wcwlb::which will be
; ::wcwd::which would
; ::wcer::whichever
; ::hl::while
; ::hle::while the
; ::o::who
; ::or/::who are
; ::oer::whoever
; ::oz::whose
; ::y::why
; ::yq::why not
; ::ye/::why the
; ::wl::will
; ::wllsb::will also be
; ::wlb::will be
; ::wlv::will have
; ::wlvbn::will have been
; ::wlq::will not
; ::wlqb::will not be
; ::w::with
; ::wrft::with reference to
; ::wrfte::with reference to the
; ::wrt::with respect to
; ::wrte::with respect to the
; ::we/::with the
; ::wi::within
; ::wie::within the
; ::wo::without
; ::woe/::without the
; ::w'::won't
; ::wk::work
; ::wkw::work with
; ::wkad::workaround
; ::wkads::workarounds
; ::wkd::worked
; ::wkr::worker
; ::wkrs::workers
; ::wkf::workflow
; ::wkfs::workflows
; ::wkg::working
; ::wex::working example
; ::wexs::working examples
; ::wkgw::working with
; ::wkt::workout
; ::wkts::workouts
; ::wkpl::workplace
; ::wkpls::workplaces
; ::wks::works
; ::wld::world
; ::wd::would
; ::wdb::would be
; ::wdv::would have
; ::wdvbn::would have been
; ::wdq::would not
; ::wdqb::would not be
; ::wd'::wouldn't
; ::wdv'::would've
; ::wt::write
; ::wts::writes
; ::wtg::writing
; ::wtn::written
; ::wtd::wrote
; ::yr::year
; ::yrl::yearly
; ::yrs::years
; ::yr'::year's
; ::yd::yesterday
; ::yd'::yesterday's
; ::u::you
; ::ur/::you are
; ::uc::you can
; ::ucls::you can also
; ::ucn::you can now
; ::uc'::you can't
; ::uv::you have
; ::umb::you may be
; ::ujd::you should
; ::uwu::you want
; ::uwl::you will
; ::ud'::you'd
; ::ul'::you'll
; ::yg::young
; ::ygr::younger
; ::ygt::youngest
; ::ur::your
; ::urti::your time
; ::ur'::you're
; ::urs::yours
; ::usf::yourself
; ::usv::yourselves
; ::uv'::you've
; ::/mum::μm
; ::/mus::μs
; ::yf::identify
; ::yfs::identifies
; ::yfd::identified
; ::yfg::identifying
; ::yfj::identification
; ::yfjs::identifications
; ::nav::in advance
; ::dlz::downloadable content
; ::qf::request
; ::qfd::requested
; ::qfs::requests
; ::qfg::requesting
; ::fmi::for more information
; ::dpl::displace
; ::dpls::displaces
; ::dpld::displaced
; ::dplg::displacing
; ::dplm::displacement
; ::dplms::displacements
; ::ookex::according to the comparison example
; ::rkv::restrictive
; ::raj::rearrange
; ::rajs::rearranges
; ::rajd::rearranged
; ::rajg::rearranging
; ::tm::transmit
; ::tms::transmits
; ::tmd::transmitted
; ::tmg::transmitting
; ::tmj::transmission
; ::rlp::relationship
; ::rlps::relationships
; ::mfjs::modifications
; ::rfckr::reference character
; ::rfckrs::reference characters
; ::sku::constitute
; ::skuy::constituted by
; ::skuye::constituted by the
; ::skus::constitutes
; ::skud::constituted
; ::skug::constituting
; ::skuj::constitution
; ::drjll::directionally
; ::xbv::thereabove
; ::dfkts::difficulties
; ::vf::verify
; ::vfs::verifies
; ::vfg::verifying
; ::vfd::verified
; ::vfj::verification
; ::xaf::thereafter
; ::csrjs::considerations
; ::hhlhs::highlights
; ::mml::momentarily
; ::vlj::voltage
; ::vljs::voltages
