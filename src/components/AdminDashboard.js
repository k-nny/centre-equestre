import React, { useEffect, useState } from 'react';
import { supabase, APP_KEY } from '../supabaseClient';
import Planning from './Planning';
import FormCavalier from './FormCavalier';
import FormCheval from './FormCheval';
import FormCours from './FormCours';
import FormAffectation from './FormAffectation';

export default function AdminDashboard() {
  const [equides, setEquides] = useState([]);
  const [cavaliers, setCavaliers] = useState([]);
  const [moniteurs, setMoniteurs] = useState([]);
  const [cours, setCours] = useState([]);
  const [affectations, setAffectations] = useState([]);

  const fetchData = async () => {
    const { data: eq } = await supabase.from('equides').select('*').eq('app_key', APP_KEY);
    const { data: cav } = await supabase.from('cavaliers').select('*').eq('app_key', APP_KEY);
    const { data: mon } = await supabase.from('moniteurs').select('*').eq('app_key', APP_KEY);
    const { data: co } = await supabase.from('cours_instances').select('*').eq('app_key', APP_KEY);
    const { data: aff } = await supabase.from('affectations').select('*').eq('app_key', APP_KEY);

    setEquides(eq || []);
    setCavaliers(cav || []);
    setMoniteurs(mon || []);
    setCours(co || []);
    setAffectations(aff || []);
  }

  useEffect(() => { fetchData() }, []);

  return (
    <div>
      <h2>Gestion Centre Équestre</h2>

      <FormCavalier fetchData={fetchData}/>
      <FormCheval fetchData={fetchData}/>
      <FormCours moniteurs={moniteurs} fetchData={fetchData}/>
      <FormAffectation cavaliers={cavaliers} equides={equides} moniteurs={moniteurs} cours={cours} fetchData={fetchData}/>

      {!cours.length && <p>Chargement des cours...</p>}
      {cours.length && (
        <Planning 
          equides={equides} 
          cavaliers={cavaliers} 
          moniteurs={moniteurs} 
          cours={cours}
          affectations={affectations}
        />
      )}
    </div>
  );
}